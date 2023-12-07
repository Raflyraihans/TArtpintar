import 'package:get/get.dart';
import 'package:rtkita/app/data/statistik.dart';
import 'package:rtkita/app/providers/statistik.dart';

class StatisikController extends GetxController {
  Statistik? statistik;

  setDataStatistik(data) {
    statistik = data;
    update();
  }

  @override
  void onInit() {
    StatistikProvider statistikProvider = StatistikProvider();
    statistikProvider.getStatistic();
    super.onInit();
  }
}
