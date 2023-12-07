import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/modules/chat/controllers/chat_controller.dart';
import 'package:rtkita/app/providers/chat.dart';

import 'app/routes/app_pages.dart';
// import 'firebase_options.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   RemoteNotification? notification = message.notification;
//   if (message.data['type'] == 'PANIC_BUTTON') {
//     final assetsAudioPlayer = AssetsAudioPlayer();
//     assetsAudioPlayer.open(
//       Audio("assets/rush.mp3"),
//       showNotification: false,
//     );
//   }
//   final ChatProvider chatProvider = ChatProvider();
//   chatProvider.getListChat();
//   final ChatController chatController = Get.put(ChatController());
//   chatController.setNewDataStatus(true);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
