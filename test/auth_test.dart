import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/modules/tab_decider/controllers/tab_decider_controller.dart';
import 'package:rtkita/app/modules/tab_decider/views/tab_decider_view.dart';
import 'package:rtkita/app/providers/auth.dart';

void main() {
  test('Login', () async {
      AuthProvider authProvider = AuthProvider();

      bool? isLogin;
      isLogin = await authProvider.login(
          phoneNumber: '081234567800', password: 'warga123');
      expect(isLogin, isA<dynamic>());
  });
}
