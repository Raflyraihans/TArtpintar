import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/app/modules/midtrans/controllers/midtrans_controller.dart';
import 'package:rtkita/app/modules/midtrans/views/bank_view.dart';
import 'package:rtkita/app/modules/tab_decider/views/tab_decider_view.dart';
import 'package:rtkita/env/global_var.dart';
import 'package:rtkita/widgets/dialog.dart';

class MidtransProvider extends GetConnect {
  GetStorage box = GetStorage();
  MidtransController midtransController = Get.put(MidtransController());
  void storeMidtrans(
      context, donationId, invoiceId, amount, payment, type) async {
    HomeController homeController = Get.put(HomeController());

    try {
      homeController.loadingStatus(true);
      final response = await post('$urlApi/midtrans', {
        'donation_id': donationId ?? '',
        'house_invoice_ipl_id': invoiceId ?? '',
        'gross_amount': amount,
        'payment_method': payment == 'lainnya' ? 'bni' : payment,
      }, headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + box.read('token')
      });
      var data = json.decode(response.bodyString.toString());
      midtransController.updateAmount(
          int.parse(data['gross_amount'].toString().split('.')[0]));
      if (data != null) {
        Get.to(() => BankView(
            data['va_numbers'][0]['va_number'].toString(),
            data['expiry_time'],
            data['va_numbers'][0]['bank'],
            data['order_id'],
            type,
            amount));
      }
      homeController.loadingStatus(false);
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage(e);
    }
  }

  void checkStatusAvailable(context, String type) async {
    HomeController homeController = Get.put(HomeController());

    try {
      homeController.loadingStatus(true);
      final response = await post('$urlApi/midtrans-check-available', {
        'type': type,
      }, headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + box.read('token')
      });
      var data = json.decode(response.bodyString.toString());

      if (data != null) {
        if (data['midtrans'] != null) {
          if (data['midtrans']['status'] == 'pending') {
            checkStatus(context, data['midtrans']['order_id'],
                type == 'ipl' ? 0 : 1, int.parse(data['midtrans']['total']), 0);
          }
        }
      }
      homeController.loadingStatus(false);
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage(e);
    }
  }

  void checkStatus(context, id, type, amount, int from) async {
    HomeController homeController = Get.put(HomeController());

    try {
      homeController.loadingStatus(true);
      final response = await post('$urlApi/midtrans-transaction-status', {
        'order_id': id,
      }, headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + box.read('token')
      });
      var data = json.decode(response.bodyString.toString());

      if (data != null) {
        if (data['transaction_status'] == 'settlement') {
          midtransUpdateStatus(id, data['transaction_status'], type, amount);
        } else {
          homeController.loadingStatus(false);
          if (data['status_code'] != '404') {
            if (from == 0) {
              Get.off(() => BankView(
                  data['va_numbers'][0]['va_number'].toString(),
                  data['expiry_time'],
                  data['va_numbers'][0]['bank'],
                  data['order_id'],
                  type,
                  amount));
            } else {
              Get.dialog(SimpleBoxDialog(
                title: 'Belum diterima',
                subtitle: 'Pembayaran belum berhasil dilakukan',
                buttonText: 'Ok',
                onTapPrimary: () {
                  Get.back();
                },
              ));
            }
          }
        }
      }
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage(e);
    }
  }

  void midtransUpdateStatus(id, status, type, amount) async {
    HomeController homeController = Get.put(HomeController());

    try {
      final response = await post('$urlApi/midtrans-update-status', {
        'order_id': id,
        'status': status,
      }, headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + box.read('token')
      });
      var data = json.decode(response.bodyString.toString());

      if (data != null) {
        try {
          final response2 = await post('$urlApi/invoice-update-status', {
            'order_id': id,
            'type': type == 0 ? 'ipl' : 'donation',
            'gross_amount': amount,
          }, headers: {
            // ignore: prefer_interpolation_to_compose_strings
            'Authorization': 'Bearer ' + box.read('token')
          });
          var data2 = json.decode(response2.bodyString.toString());
          if (data2 != null) {
            Get.dialog(
                SimpleBoxDialog(
                  title: 'Pembayaran Berhasil!',
                  subtitle: 'Pembayaran telah berhasil dilakukan',
                  buttonText: 'Ok',
                  onTapPrimary: () {
                    Get.offAll(() => TabDeciderView());
                  },
                ),
                barrierDismissible: false);
          }
        } catch (e) {
          errorMessage(e);
        }
      }
      homeController.loadingStatus(false);
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage(e);
    }
  }
}
