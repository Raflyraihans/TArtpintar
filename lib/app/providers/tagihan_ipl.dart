import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/data/invoice.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/env/global_var.dart';

class TagihanProvider extends GetConnect {
  GetStorage box = GetStorage();
  void getListInvoice() async {
    List<Invoice> invoice = [];

    try {
      HomeController homeController = Get.put(HomeController());
      homeController.loadingStatus(true);
      final response = await get('$urlApi/iuran',
          // ignore: prefer_interpolation_to_compose_strings
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      print("data iuran : $data");
      homeController.loadingStatus(false);
      if (data != null) {
        if (data['invoice'] != null) {
          data['invoice'].forEach((v) => invoice.add(Invoice.fromJson(v)));
        }
        homeController.setInvoiceData(invoice);
      }
    } catch (e) {
      errorMessage(e);
    }
  }
}
