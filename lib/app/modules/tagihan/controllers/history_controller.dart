import 'package:get/get.dart';

class HistoryController extends GetxController {
  List? midtrans = [];

  setMidtransData(data) {
    midtrans = data;

    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
