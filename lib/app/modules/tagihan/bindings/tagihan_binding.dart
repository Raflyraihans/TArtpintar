import 'package:get/get.dart';

import 'package:rtkita/app/modules/tagihan/controllers/history_controller.dart';

import '../controllers/tagihan_controller.dart';

class TagihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
    Get.lazyPut<TagihanController>(
      () => TagihanController(),
    );
  }
}
