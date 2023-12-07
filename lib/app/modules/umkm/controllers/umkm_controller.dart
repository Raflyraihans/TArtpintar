import 'package:get/get.dart';

class UmkmController extends GetxController {
  // ignore: todo
  //TODO: Implement UmkmController

  int selectedTab = 0;

  changeTab(index) {
    selectedTab = index;
    update();
  }
}
