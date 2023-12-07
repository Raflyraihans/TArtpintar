// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/data/statistik.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/app/modules/statisik/controllers/statisik_controller.dart';
import 'package:rtkita/env/global_var.dart';

class StatistikProvider extends GetConnect {
  GetStorage box = GetStorage();
  void getStatistic() async {
    Statistik? statistik;
    HomeController homeController = Get.put(HomeController());

    try {
      homeController.loadingStatus(true);
      final response = await get('$urlApi/statistik',
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      print(data);
      if (data != null) {
        statistik = Statistik.fromJson(data);
        StatisikController statisikController = Get.put(StatisikController());
        statisikController.setDataStatistik(statistik);
      }
      homeController.loadingStatus(false);
    } catch (e) {
      errorMessage(e);
    }
  }
}
