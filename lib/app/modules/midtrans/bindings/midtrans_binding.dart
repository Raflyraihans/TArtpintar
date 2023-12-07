import 'package:get/get.dart';

import '../controllers/midtrans_controller.dart';

class MidtransBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MidtransController>(
      () => MidtransController(),
    );
  }
}
