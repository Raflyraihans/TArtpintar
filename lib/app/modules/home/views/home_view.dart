// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/modules/Manajemen_Iuran/views/manajemen_iuran_view.dart';
import 'package:rtkita/app/modules/aduan/views/aduan_view.dart';
import 'package:rtkita/app/modules/donation/views/donation_view.dart';
import 'package:rtkita/app/modules/epolling/controllers/epolling_controller.dart';
import 'package:rtkita/app/modules/epolling/views/epolling_view.dart';
import 'package:rtkita/app/modules/iuran/views/iuran_view.dart';
import 'package:rtkita/app/modules/kontak/views/kontak_view.dart';
import 'package:rtkita/app/modules/manajemenAduanWarga/views/manajemen_aduan_warga_view.dart';
import 'package:rtkita/app/modules/manajemenPengumuman/views/manajemen_pengumuman_view.dart';
import 'package:rtkita/app/modules/manajemenPersuratan/views/manajemen_persuratan_view.dart';
import 'package:rtkita/app/modules/midtrans/providers/midtrans.dart';
import 'package:rtkita/app/modules/pengumuman/views/pengumuman_view.dart';
import 'package:rtkita/app/modules/persuratan/views/persuratan_view.dart';
import 'package:rtkita/app/modules/statisik/views/statisik_view.dart';
import 'package:rtkita/app/modules/tab_decider/controllers/tab_decider_controller.dart';
import 'package:rtkita/app/modules/tagihan/views/tagihan_view.dart';
import 'package:rtkita/app/modules/umkm/views/umkm_view.dart';
import 'package:rtkita/app/providers/auth.dart';
import 'package:rtkita/app/providers/tagihan_ipl.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/card_berita.dart';
import 'package:rtkita/widgets/dialog.dart';
import 'package:rtkita/widgets/menu_item.dart';
import 'package:rtkita/widgets/section_part.dart';
import 'package:rtkita/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/announcement.dart';
import '../controllers/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  final AnnouncementProvider announcementProvider = AnnouncementProvider();
  // final ArticleProvider articleProvider = ArticleProvider();
  final TagihanProvider tagihanProvider = TagihanProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        final AnnouncementProvider announcementProvider =
                            AnnouncementProvider();
                        // final ArticleProvider articleProvider =
                        //     ArticleProvider();
                        final TagihanProvider tagihanProvider =
                            TagihanProvider();
                        announcementProvider.getListAnnouncement();
                        // articleProvider.getListArticle();
                        tagihanProvider.getListInvoice();
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  // height: 170,
                                  height: 70,
                                  child: Container(
                                    transform:
                                        Matrix4.translationValues(0, 0, 0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    color: primaryColor,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GetBuilder<TabDeciderController>(
                                            init: TabDeciderController(),
                                            builder: (c) {
                                              return CText(
                                                'Halo, ${c.user!.familyMemberName!}',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              );
                                            }),
                                        const CText(
                                          'Apa kabar anda hari ini?',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              transform: Matrix4.translationValues(0, -0, 0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  // Container(
                                  //   height: 175,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(20),
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  // GetBuilder<HomeController>(
                                  //     init: HomeController(),
                                  //     initState: (state) async {
                                  //       await Future.delayed(Duration.zero);
                                  //       final AnnouncementProvider
                                  //           announcementProvider =
                                  //           AnnouncementProvider();
                                  //       final ArticleProvider articleProvider =
                                  //           ArticleProvider();
                                  //       final TagihanProvider tagihanProvider =
                                  //           TagihanProvider();
                                  //       announcementProvider.getListAnnouncement();
                                  //       articleProvider.getListArticle();
                                  //       tagihanProvider.getListInvoice();
                                  //     },
                                  //     builder: (c) {
                                  //       return c.invoice.isEmpty != true
                                  //           ? Container(
                                  //               padding: const EdgeInsets.symmetric(
                                  //                   horizontal: 24, vertical: 14),
                                  //               decoration: BoxDecoration(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(20),
                                  //                   border: Border.all(
                                  //                       color: Colors.grey
                                  //                           .withOpacity(0.5))),
                                  //               child: Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment
                                  //                         .spaceBetween,
                                  //                 children: [
                                  //                   Column(
                                  //                     crossAxisAlignment:
                                  //                         CrossAxisAlignment.start,
                                  //                     children: [
                                  //                       const CText(
                                  //                           'Total Tagihan IPL'),
                                  //                       const SizedBox(
                                  //                         height: 4,
                                  //                       ),
                                  //                       CText(
                                  //                         CurrencyFormat.convertToIdr(
                                  //                             int.parse(c.invoice
                                  //                                     .isEmpty
                                  //                                 ? '0'
                                  //                                 : c
                                  //                                     .invoice[c
                                  //                                             .invoice
                                  //                                             .length -
                                  //                                         1]
                                  //                                     .house!
                                  //                                     .invoiceIpl!),
                                  //                             0),
                                  //                         color: dangerRed,
                                  //                         fontWeight:
                                  //                             FontWeight.bold,
                                  //                         fontSize: 16,
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                   CText(
                                  //                     c.invoice.isEmpty
                                  //                         ? ''
                                  //                         : '${c.invoice[c.invoice.length - 1].invoiceIpl!.date!.substring(0, 3)}/${c.invoice[c.invoice.length - 1].invoiceIpl!.date!.split('/')[1]}',
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w500,
                                  //                   ),
                                  //                   Row(
                                  //                     children: [
                                  //                       Container(
                                  //                         height: 46,
                                  //                         width: 1,
                                  //                         color: Colors.grey,
                                  //                       ),
                                  //                       const SizedBox(
                                  //                         width: 16,
                                  //                       ),
                                  //                       GestureDetector(
                                  //                         onTap: () {
                                  //                           Get.to(() =>
                                  //                               TagihanView());
                                  //                           final MidtransProvider
                                  //                               midtransProvider =
                                  //                               MidtransProvider();
                                  //                           midtransProvider
                                  //                               .checkStatusAvailable(
                                  //                                   context, 'ipl');
                                  //                         },
                                  //                         child: Column(
                                  //                           children: [
                                  //                             Container(
                                  //                               height: 30,
                                  //                               width: 30,
                                  //                               decoration: BoxDecoration(
                                  //                                   shape: BoxShape
                                  //                                       .circle,
                                  //                                   color:
                                  //                                       menuColor),
                                  //                               child: const Icon(
                                  //                                 Icons
                                  //                                     .keyboard_arrow_right,
                                  //                                 color:
                                  //                                     Colors.white,
                                  //                               ),
                                  //                             ),
                                  //                             const SizedBox(
                                  //                               height: 5,
                                  //                             ),
                                  //                             CText(
                                  //                               'Bayar',
                                  //                               color: menuColor,
                                  //                             )
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             )
                                  //           : Container();
                                  //     }),
                                  // const SizedBox(
                                  //   height: 24,
                                  // ),
                                  GridView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1 / 1),
                                    children: [
                                      // CMenuItem(
                                      //   icon: FluentIcons.money_24_filled,
                                      //   text: 'Pembayaran IPL',
                                      //   onTap: () {
                                      //     Get.to(() => TagihanView());
                                      //     final MidtransProvider
                                      //         midtransProvider =
                                      //         MidtransProvider();
                                      //     midtransProvider.checkStatusAvailable(
                                      //         context, 'ipl');
                                      //   },
                                      // ),
                                      CMenuItem(
                                        icon: FluentIcons.money_24_filled,
                                        text: 'Iuran Warga',
                                        onTap: () {
                                          Get.to(() => DonationView());
                                        },
                                      ),
                                      CMenuItem(
                                        icon: FluentIcons.call_24_filled,
                                        text: 'No. Penting',
                                        onTap: () {
                                          Get.to(() => KontakView());
                                        },
                                      ),
                                      GetBuilder<EpollingController>(
                                          init: EpollingController(),
                                          initState: (state) async {
                                            // await Future.delayed(Duration.zero);
                                            // FirebaseMessaging.onMessage.listen(
                                            //     (RemoteMessage message) {
                                            //   if (message.data['type'] ==
                                            //       'Polling') {
                                            //     state.controller!
                                            //         .setNewDataStatus(true);
                                            //   }
                                            // });
                                          },
                                          builder: (polling) {
                                            return Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  right: 0,
                                                  bottom: 0,
                                                  child: CMenuItem(
                                                    icon: FluentIcons
                                                        .poll_24_filled,
                                                    text: 'E-Polling',
                                                    onTap: () {
                                                      polling.setNewDataStatus(
                                                          false);
                                                      Get.to(
                                                          () => EpollingView());
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  right: 20,
                                                  child: Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                      color: polling.newData ==
                                                              true
                                                          ? Colors.red
                                                          : Colors.transparent,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      CMenuItem(
                                        icon: FluentIcons.warning_24_filled,
                                        text: 'Aduan',
                                        onTap: () {
                                          Get.to(() => AduanView());
                                        },
                                      ),
                                      CMenuItem(
                                        icon: FluentIcons.folder_24_filled,
                                        text: 'Persuratan',
                                        onTap: () {
                                          Get.to(() => PersuratanView());
                                        },
                                      ),
                                    ],
                                  ),
                                  GetBuilder<TabDeciderController>(
                                      init: TabDeciderController(),
                                      builder: (c) {
                                        return c.box.read('role') != 'admin'
                                            ? Container()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                    child: const SectionPart(
                                                        text: 'Menu Pengurus'),
                                                  ),
                                                  GridView(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio:
                                                                1 / 1),
                                                    children: [
                                                      CMenuItem(
                                                        icon: FluentIcons
                                                            .poll_24_filled,
                                                        text:
                                                            'Manajemen\nAduan Warga',
                                                        onTap: () {
                                                          Get.to(() =>
                                                              const ManajemenAduanWargaView());
                                                        },
                                                      ),
                                                      CMenuItem(
                                                        icon: FluentIcons
                                                            .folder_24_filled,
                                                        text:
                                                            'Manajemen Persuratan',
                                                        onTap: () {
                                                          Get.to(() =>
                                                              ManajemenPersuratanView());
                                                        },
                                                      ),
                                                      CMenuItem(
                                                        icon: FluentIcons
                                                            .list_24_filled,
                                                        text:
                                                            'Manajemen Pengumuman',
                                                        onTap: () {
                                                          Get.to(() =>
                                                              ManajemenPengumumanView());
                                                        },
                                                      ),
                                                      CMenuItem(
                                                        icon: FluentIcons
                                                            .money_16_filled,
                                                        text:
                                                            'Manajemen\nIuran',
                                                        onTap: () {
                                                          Get.to(() =>
                                                              ManajemenIuranView());
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                      }),
                                  const SizedBox(height: 30),
                                  SectionPart(
                                      text: 'Pengumuman untuk Warga',
                                      onTap: () {
                                        Get.to(() => PengumumanView());
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GetBuilder<HomeController>(
                                      init: HomeController(),
                                      initState: (state) {
                                        announcementProvider
                                            .getListAnnouncement();
                                      },
                                      builder: (c) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: c.announcement.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset:
                                                          const Offset(0, 1),
                                                      blurRadius: 15.0),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(c.announcement[index]
                                                              .title !=
                                                          null
                                                      ? c.announcement[index]
                                                          .title!
                                                      : "", fontWeight: FontWeight.w600,),
                                                  const SizedBox(height: 4,),
                                                  CText(c.announcement[index]
                                                              .description !=
                                                          null
                                                      ? c.announcement[index]
                                                          .description!
                                                      : ""),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                  // const SizedBox(height: 30),
                                  // const SectionPart(
                                  //     text: 'Berita dan Kabar Terbaru'),
                                  // const SizedBox(height: 10),
                                  // Row(
                                  //   children: const [
                                  //     CText(
                                  //         'Berita dan kabar terbaru yang perlu anda ketahui\nhari ini.'),
                                  //   ],
                                  // ),
                                  // const SizedBox(height: 10),
                                  // GetBuilder<HomeController>(
                                  //     init: HomeController(),
                                  //     builder: (c) {
                                  //       return c.article.isEmpty
                                  //           ? Container()
                                  //           : ListView.builder(
                                  //               shrinkWrap: true,
                                  //               physics:
                                  //                   const NeverScrollableScrollPhysics(),
                                  //               itemCount: 5,
                                  //               itemBuilder: (context, index) {
                                  //                 timeago.setLocaleMessages(
                                  //                     'id',
                                  //                     timeago.IdMessages());
                                  //                 return GestureDetector(
                                  //                   onTap: () {
                                  //                     launchUrl(
                                  //                         Uri.parse(c
                                  //                             .article[index]
                                  //                             .url!),
                                  //                         mode: LaunchMode
                                  //                             .externalApplication);
                                  //                   },
                                  //                   child: CardBerita(
                                  //                       picture: c
                                  //                               .article[index]
                                  //                               .urlToImage ??
                                  //                           'https://jdih.kominfo.go.id/storage/pictures/default.jpg',
                                  //                       account: c
                                  //                               .article[index]
                                  //                               .source!
                                  //                               .name ??
                                  //                           'Berita',
                                  //                       description: c
                                  //                           .article[index]
                                  //                           .description
                                  //                           .toString(),
                                  //                       time: timeago.format(
                                  //                           DateTime.parse(c
                                  //                               .article[index]
                                  //                               .publishedAt
                                  //                               .toString()),
                                  //                           locale: 'id')),
                                  //                 );
                                  //               },
                                  //             );
                                  //     }),

                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/image/logo_home.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
