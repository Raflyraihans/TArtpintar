// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/data/polling.dart';
import 'package:rtkita/app/modules/epolling/controllers/epolling_controller.dart';
import 'package:rtkita/app/modules/epolling/views/epolling_view.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/env/global_var.dart';

class PollingProvider extends GetConnect {
  GetStorage box = GetStorage();
  void getListPolling() async {
    List<Polling?> polling = [];

    EpollingController pollingController = Get.put(EpollingController());
    HomeController homeController = Get.find<HomeController>();

    try {
      homeController.loadingStatus(true);
      final response = await get('$urlApi/polling',
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      print("data polling : $data");
      homeController.loadingStatus(false);
      if (data != null) {
        data['data']['polling']
            .forEach((v) => polling.add(Polling.fromJson(v)));
        pollingController.setPolling(polling);
      }
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage("Terjadi kesalahan dalam memuat polling");
    }
  }

  void selectPolling(context, id, pollingId) async {
    // ignore: unused_local_variable
    EpollingController pollingController = Get.put(EpollingController());
    HomeController homeController = Get.put(HomeController());

    homeController.loadingStatus(true);
    try {
      final response = await post('$urlApi/polling', {
        'polling_option_id': id,
      }, headers: {
        'Authorization': 'Bearer ' + box.read('token')
      });
      var data = json.decode(response.bodyString.toString());
      if (data['status'] != 'OK') {
        errorMessage(data['message'].toString());
      } else {
        Get.off(EpollingView());
        successMessage(context, 'Polling berhasil dipilih!');
      }
      getDetailPolling(pollingId.toString());
    } catch (e) {
      errorMessage("Terjadi kesalahan dalam memuat polling");
    }
    homeController.loadingStatus(false);
  }

  void getDetailPolling(pollingId) async {
    List<PollingOptions?> polling = [];

    EpollingController pollingController = Get.put(EpollingController());
    // ignore: unused_local_variable
    HomeController homeController = Get.put(HomeController());
    await Future.delayed(Duration.zero);
    pollingController.setDataPolling(null);
    homeController.loadingStatus(true);
    try {
      final response = await get('$urlApi/polling/' + pollingId,
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      print("data detail polling : $data");
      if (data != null) {
        data['polling']['polling_option']
            .forEach((v) => polling.add(PollingOptions.fromJson(v)));

        if (data['check_polling'] != null) {
          pollingController.updateVote(true);
          pollingController.setDataPolling(data['check_polling']);
        } else {
          pollingController.setDataPolling(null);
        }
      }
    } catch (e) {
      errorMessage("Terjadi kesalahan dalam memuat polling");
    }
    homeController.loadingStatus(false);
  }
}
