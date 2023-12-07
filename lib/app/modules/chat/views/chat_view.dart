import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/modules/chat/views/grup_chat_view.dart';
import 'package:rtkita/app/modules/tab_decider/controllers/tab_decider_controller.dart';
import 'package:rtkita/app/providers/chat.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/chat_bubble.dart';
import 'package:rtkita/widgets/text.dart';

import '../controllers/chat_controller.dart';

// ignore: must_be_immutable
class ChatView extends GetView<ChatController> {
  ChatView({Key? key}) : super(key: key);

  TextEditingController message = TextEditingController();
  final TabDeciderController tabDeciderController =
      Get.put(TabDeciderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 10))
                  ]),
              // ignore: prefer_const_literals_to_create_immutables
              child: Row(children: [
                Expanded(
                  child: Container(
                      transform: Matrix4.translationValues(-20, 0, 0),
                      // ignore: prefer_const_constructors
                      child: BackButton()),
                ),
                // ignore: prefer_const_constructors
                Expanded(
                  flex: 2,
                  child: Container(
                    transform: Matrix4.translationValues(-40, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const GrupChatView());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Grup Chat',
                            style: TextStyle(
                              // ignore: unnecessary_const
                              color: Color(0xff25446F),
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Lihat anggota grup..',
                            style: TextStyle(
                              // ignore: unnecessary_const
                              color: subtextColor,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ]),
            ),
            Expanded(
              child: GetBuilder<ChatController>(
                  init: ChatController(),
                  builder: (c) {
                    return NotificationListener(
                      child: Stack(
                        children: [
                          ListView.builder(
                            reverse: true,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            controller: c.listviewController,
                            itemCount: c.chat.length,
                            cacheExtent: 99999,
                            itemBuilder: (context, index) {
                              DateTime dataCreated = DateTime.now();
                              if (c.chat[index].createdAt != '') {
                                dataCreated =
                                    DateTime.parse(c.chat[index].createdAt!);
                              }
                              if (DateFormat('d-M-y').format(
                                      DateTime.parse(dataCreated.toString())) !=
                                  DateFormat('d-M-y').format(DateTime.parse(c
                                      .chat[index == (c.chat.length - 1)
                                          ? index
                                          : index + 1]
                                      .createdAt!))) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: CText(
                                          DateFormat('d MMM').format(
                                                      DateTime.parse(c
                                                          .chat[index]
                                                          .createdAt!)) ==
                                                  DateFormat('d MMM')
                                                      .format(DateTime.now())
                                              ? 'Hari Ini'
                                              : DateFormat('d MMM').format(
                                                  DateTime.parse(c
                                                      .chat[index].createdAt!)),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ChatBubble(
                                      other: c.chat[index].username !=
                                          tabDeciderController
                                              .user!.familyMemberName,
                                      username: c.chat[index].username!,
                                      message: c.chat[index].message!,
                                      created_at: c.chat[index].createdAt!
                                          .replaceAll('T', ' ')
                                          .split('.')[0],
                                      file: c.chat[index].file ?? '',
                                    ),
                                  ],
                                );
                              } else {
                                return ChatBubble(
                                    other: c.chat[index].username !=
                                        tabDeciderController
                                            .user!.familyMemberName,
                                    username: c.chat[index].username!,
                                    message: c.chat[index].message!,
                                    created_at: c.chat[index].createdAt!
                                        .replaceAll('T', ' ')
                                        .split('.')[0],
                                    file: c.chat[index].file ?? '');
                              }
                            },
                          ),
                          AnimatedPositioned(
                            right: 20,
                            bottom: c.scrollToBottom == false ? -50 : 20,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            child: GestureDetector(
                              onTap: () {
                                Timer(const Duration(milliseconds: 500), () {
                                  c.listviewController.animateTo(
                                    c.listviewController.position
                                        .minScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 15.0),
                                ], shape: BoxShape.circle, color: primaryColor),
                                child: const Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onNotification: (t) {
                        if (t is ScrollEndNotification) {
                          if (c.listviewController.position.pixels ==
                              c.listviewController.position.minScrollExtent) {
                            c.setScrolltoBottom(false);
                          } else {
                            c.setScrolltoBottom(true);
                          }
                        }
                        return true;
                      },
                    );
                  }),
            ),
            GetBuilder<ChatController>(
                init: ChatController(),
                builder: (c) {
                  return Container(
                    height: 80,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          offset: const Offset(0, -6),
                          blurRadius: 8.0),
                    ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: message,
                              onTap: () {
                                if (c.listviewController.position.pixels ==
                                    c.listviewController.position
                                        .minScrollExtent) {
                                  c.listviewController.jumpTo(c
                                      .listviewController
                                      .position
                                      .minScrollExtent);
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      final ImagePicker picker = ImagePicker();
                                      Get.bottomSheet(
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: const CText(
                                                'Pilih File..',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Material(
                                              color: Colors.white,
                                              child: ListTile(
                                                onTap: () async {
                                                  try {
                                                    XFile? data =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                            maxHeight: 640);
                                                    if (data != null) {
                                                      final ChatProvider
                                                          chatProvider =
                                                          ChatProvider();
                                                      c.addphoto(
                                                          tabDeciderController
                                                              .user!
                                                              .familyMemberName);
                                                      chatProvider
                                                          .sendGambar(data);
                                                    }
                                                  } on PlatformException {
                                                    errorMessage(
                                                        'Platform Error');
                                                  } catch (e) {
                                                    errorMessage(e);
                                                  }
                                                  Get.back();
                                                },
                                                leading: const Icon(
                                                  FluentIcons.camera_24_regular,
                                                  color: Colors.black,
                                                ),
                                                title: const Text('Camera'),
                                              ),
                                            ),
                                            Material(
                                              color: Colors.white,
                                              child: ListTile(
                                                onTap: () async {
                                                  try {
                                                    XFile? data =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                            maxHeight: 640);
                                                    if (data != null) {
                                                      final ChatProvider
                                                          chatProvider =
                                                          ChatProvider();
                                                      c.addphoto(
                                                          tabDeciderController
                                                              .user!
                                                              .familyMemberName);
                                                      chatProvider
                                                          .sendGambar(data);
                                                    }
                                                  } on PlatformException {
                                                    errorMessage(
                                                        'Platform Error');
                                                  } catch (e) {
                                                    errorMessage(e);
                                                  }
                                                  Get.back();
                                                },
                                                leading: const Icon(
                                                  FluentIcons.image_24_regular,
                                                  color: Colors.black,
                                                ),
                                                title: const Text('Galeri'),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  hintText: 'Ketik Pesan..'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Material(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {
                              if (message.text != '') {
                                final ChatProvider chatProvider =
                                    ChatProvider();
                                chatProvider.sendChat(message.text);
                                c.addChat(
                                    tabDeciderController.user!.familyMemberName,
                                    message.text);

                                message.clear();
                              }
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: const Icon(
                                Icons.send,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
