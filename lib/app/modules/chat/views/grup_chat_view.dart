import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/modules/chat/controllers/chat_controller.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/dialog.dart';
import 'package:rtkita/widgets/full_screen_image.dart';
import 'package:rtkita/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

class GrupChatView extends GetView {
  const GrupChatView({Key? key}) : super(key: key);
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
                  child: const Center(
                    child: Text(
                      'Anggota',
                      style: TextStyle(
                        // ignore: unnecessary_const
                        color: Color(0xff25446F),
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ]),
            ),
            GetBuilder<ChatController>(
                init: ChatController(),
                builder: (c) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextField(
                      controller: c.anggota,
                      onChanged: (value) {
                        c.searchWarga();
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Cari nama...',
                        prefixIcon: const Icon(FluentIcons.search_24_regular),
                      ),
                    ),
                  );
                }),
            Expanded(
              child: GetBuilder<ChatController>(
                  init: ChatController(),
                  builder: (c) {
                    return ListView.builder(
                      itemCount: c.anggota.text != ''
                          ? c.pencarian.length
                          : c.warga.length,
                      itemBuilder: (context, index) {
                        var data = c.anggota.text != '' ? c.pencarian : c.warga;
                        return InkWell(
                          onTap: () {
                            Get.dialog(SimpleBoxDialog(
                              title: 'Informasi User',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (data[index]
                                                  .user!
                                                  .familyMember!
                                                  .avatar !=
                                              '') {
                                            // Get.to(() => FullScreenImage(
                                            //       image: data[index]
                                            //           .user!
                                            //           .familyMember!
                                            //           .avatar!,
                                            //     ));
                                          }
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          child: data[index]
                                                      .user!
                                                      .familyMember!
                                                      .avatar !=
                                                  ''
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Hero(
                                                    tag: data[index]
                                                        .user!
                                                        .familyMember!
                                                        .avatar!,
                                                    child: CachedNetworkImage(
                                                      imageUrl: data[index]
                                                          .user!
                                                          .familyMember!
                                                          .avatar!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Icon(
                                                      FluentIcons
                                                          .person_24_regular,
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Center(
                                    child: CText(
                                      data[index]
                                          .user!
                                          .familyMember!
                                          .familyMemberName!,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Material(
                                        color: Colors.white,
                                        child: IconButton(
                                          onPressed: () async {
                                            String notelp = '';
                                            if (data[index]
                                                    .user!
                                                    .phoneNumber![0] ==
                                                '0') {
                                              // ignore: prefer_interpolation_to_compose_strings
                                              notelp = '+62' +
                                                  data[index]
                                                      .user!
                                                      .phoneNumber!
                                                      .substring(
                                                          1,
                                                          data[index]
                                                              .user!
                                                              .phoneNumber!
                                                              .length);
                                            } else {
                                              notelp = data[index]
                                                  .user!
                                                  .phoneNumber!;
                                            }
                                            var whatsappUrl =
                                                "whatsapp://send?phone=+${notelp}";
                                            await canLaunchUrl(
                                                    Uri.parse(whatsappUrl))
                                                ? launchUrl(
                                                    Uri.parse(whatsappUrl))
                                                : errorMessage(
                                                    'Whatsapp not installed');
                                          },
                                          icon:
                                              const Icon(Icons.question_answer),
                                          color: Colors.green,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: IconButton(
                                          onPressed: () async {
                                            final Uri launchUri = Uri(
                                              scheme: 'tel',
                                              path: data[index]
                                                  .user!
                                                  .phoneNumber!,
                                            );
                                            await launchUrl(launchUri);
                                          },
                                          icon: const Icon(
                                              FluentIcons.call_24_regular),
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Center(
                                    child: CText(
                                      data[index]
                                          .user!
                                          .familyMember!
                                          .address!
                                          .split(', ')
                                          .last,
                                      color: subtextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Center(
                                    child: CText(
                                      data[index].user!.phoneNumber!,
                                      color: subtextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        child: data[index]
                                                    .user!
                                                    .familyMember!
                                                    .avatar !=
                                                ''
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl: data[index]
                                                      .user!
                                                      .familyMember!
                                                      .avatar!,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Center(
                                                child: Icon(
                                                    FluentIcons
                                                        .person_24_regular,
                                                    color: Colors.white),
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              data[index]
                                                  .user!
                                                  .familyMember!
                                                  .familyMemberName!,
                                              fontSize: 16,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            CText(
                                              data[index]
                                                  .user!
                                                  .familyMember!
                                                  .address!
                                                  .split(', ')
                                                  .last,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              color: subtextColor,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            CText(
                                              data[index].user!.phoneNumber!,
                                              color: subtextColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      transform:
                                          Matrix4.translationValues(10, 0, 0),
                                      child: IconButton(
                                        onPressed: () async {
                                          String notelp = '';
                                          if (data[index]
                                                  .user!
                                                  .phoneNumber![0] ==
                                              '0') {
                                            // ignore: prefer_interpolation_to_compose_strings
                                            notelp = '+62' +
                                                data[index]
                                                    .user!
                                                    .phoneNumber!
                                                    .substring(
                                                        1,
                                                        data[index]
                                                            .user!
                                                            .phoneNumber!
                                                            .length);
                                          } else {
                                            notelp =
                                                data[index].user!.phoneNumber!;
                                          }
                                          var whatsappUrl =
                                              "whatsapp://send?phone=+${notelp}";
                                          await canLaunchUrl(
                                                  Uri.parse(whatsappUrl))
                                              ? launchUrl(
                                                  Uri.parse(whatsappUrl))
                                              : errorMessage(
                                                  'Whatsapp not installed');
                                        },
                                        icon: const Icon(Icons.question_answer),
                                        color: Colors.green,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path: data[index].user!.phoneNumber!,
                                        );
                                        await launchUrl(launchUri);
                                      },
                                      icon: const Icon(
                                          FluentIcons.call_24_regular),
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
