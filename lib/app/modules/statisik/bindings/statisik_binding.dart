import 'package:get/get.dart';

import '../controllers/statisik_controller.dart';

class StatisikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisikController>(
      () => StatisikController(),
    );
  }
}
