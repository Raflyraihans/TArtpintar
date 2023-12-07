// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/data/chat.dart';
import 'package:rtkita/app/data/warga.dart';
import 'package:rtkita/app/modules/chat/controllers/chat_controller.dart';
import 'package:rtkita/env/global_var.dart';

class ChatProvider extends GetConnect {
  GetStorage box = GetStorage();
  void getListChat() async {
    List<Chat> chat = [];

    try {
      final response = await get('$urlApi/chat',
          // ignore: prefer_interpolation_to_compose_strings
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      if (data != null) {
        if (data['chat'] != null) {
          data['chat'].forEach((v) => chat.add(Chat.fromJson(v)));
          ChatController chatController = Get.put(ChatController());
          chatController.setChatData(chat);
          if (chatController.listviewController.hasClients) {
            Future.delayed(const Duration(seconds: 2), () {
              chatController.listviewController.jumpTo(
                  chatController.listviewController.position.minScrollExtent);
              chatController.setNewDataStatus(false);
            });
          }
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void getAnggotaGrup() async {
    List<Warga> user = [];

    try {
      final response = await get('$urlApi/anggota-grup',
          // ignore: prefer_interpolation_to_compose_strings
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      if (data != null) {
        if (data['warga'] != null) {
          data['warga'].forEach((v) => user.add(Warga.fromJson(v)));
          ChatController chatController = Get.put(ChatController());
          chatController.setWargaData(user);
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void sendChat(message) async {
    try {
      final response = await post('$urlApi/chat', {
        'message': message,
      }, headers: {
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + box.read('token')
      });
      // ignore: unused_local_variable
      var data = json.decode(response.bodyString.toString());
      getListChat();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void sendGambar(file) async {
    try {
      final form = FormData({
        'message': 'Mengirim foto..',
        'file': MultipartFile(file!.path.toString(),
            filename: 'file' + file!.path.split('/').last),
      });
      final response = await post('$urlApi/chat', form,
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      // ignore: unused_local_variable
      var data = json.decode(response.bodyString.toString());
      getListChat();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
