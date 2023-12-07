import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtkita/app/data/chat.dart';
import 'package:rtkita/app/data/warga.dart';
import 'package:rtkita/app/providers/chat.dart';

class ChatController extends GetxController {
  List<Chat> chat = [];
  List<Warga> warga = [];
  ScrollController listviewController = ScrollController();
  bool scrollToBottom = false;
  bool newData = false;
  TextEditingController anggota = TextEditingController();
  List<Warga> pencarian = [];

  searchWarga() {
    pencarian.clear();
    for (var element in warga) {
      if (element.user!.familyMember!.familyMemberName!
          .toLowerCase()
          .contains(anggota.text.toLowerCase())) {
        if (!pencarian.contains(element)) {
          pencarian.add(element);
        }
      }
    }
    update();
  }

  setNewDataStatus(status) {
    newData = status;
    update();
  }

  void setChatData(data) {
    chat = data;
    update();
  }

  void setWargaData(data) {
    warga = data;
    update();
  }

  setScrolltoBottom(data) {
    scrollToBottom = data;
    update();
  }

  void addChat(username, message) {
    chat.insert(
        0,
        Chat.fromJson({
          'username': username,
          'message': message,
          'created_at': '',
        }));
    // ignore: unused_local_variable
    final ChatProvider chatProvider = ChatProvider();
    update();
  }

  void addphoto(username) {
    chat.insert(
        0,
        Chat.fromJson({
          'username': username,
          'message': 'Mengirim foto..',
          'file': 'file',
          'created_at': '',
        }));
    // ignore: unused_local_variable
    final ChatProvider chatProvider = ChatProvider();
    update();
  }

  @override
  void onInit() async {
    final ChatProvider chatProvider = ChatProvider();
    chatProvider.getListChat();
    chatProvider.getAnggotaGrup();
    super.onInit();
  }
}
