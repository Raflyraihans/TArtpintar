import 'package:get/get.dart';

class MidtransController extends GetxController {
  String selectedPembayaran = '';
  int amount = 0;

  void selectPembayaran(pembayaran) {
    selectedPembayaran = pembayaran;
    update();
  }

  void updateAmount(data) {
    amount = data;
    update();
  }
}
