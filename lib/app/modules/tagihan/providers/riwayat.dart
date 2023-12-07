import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/app/modules/tagihan/controllers/history_controller.dart';
import 'package:rtkita/env/global_var.dart';

class RiwayatTagihanProvider extends GetConnect {
  GetStorage box = GetStorage();
  void getListMidtrans() async {
    List? midtrans = [];

    try {
      final HomeController homeController = Get.put(HomeController());
      homeController.loadingStatus(true);
      final response = await get('$urlApi/history-ipl',
          // ignore: prefer_interpolation_to_compose_strings
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      print(data);
      if (data != null) {
        if (data['midtrans'] != null) {
          HistoryController riwayatController = Get.put(HistoryController());
          riwayatController.setMidtransData(data['midtrans']);
        }
      }
      homeController.loadingStatus(false);
      // ignore: empty_catches
    } catch (e) {}
  }
}
