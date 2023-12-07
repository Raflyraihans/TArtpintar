import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/modules/tab_decider/controllers/tab_decider_controller.dart';
import 'package:rtkita/app/modules/tab_decider/views/tab_decider_view.dart';
import 'package:rtkita/app/providers/auth.dart';

void main() {
  group('Auth', () {
    test('Login', () async {
      AuthProvider authProvider = AuthProvider();

      bool? isLogin;
      isLogin = await authProvider.login(
          phoneNumber: '081234567800', password: 'warga123');
      expect(isLogin, isA<dynamic>());
    });
    test('GetDataDiri', () async {
      AuthProvider authProvider = AuthProvider();
      Get.put(TabDeciderController());

      bool? isGetDataDiri = false;
      isGetDataDiri = await authProvider.getDataDiri(
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3J0LXBpbnRhci5pbWFnaS5pZC9hcGkvdjEvbG9naW4td2FyZ2EiLCJpYXQiOjE3MDE2NjE2MDYsImV4cCI6MTcwMTY2NTIwNiwibmJmIjoxNzAxNjYxNjA2LCJqdGkiOiJYZ3BoSFBtNXdSbVN2Z0lzIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.BtBL7LxP3NvmEqlX0F-yy4KzmFc-4t1JVLjDiVgiKO4');
      expect(isGetDataDiri, isA<dynamic>());
    });
  });
}
