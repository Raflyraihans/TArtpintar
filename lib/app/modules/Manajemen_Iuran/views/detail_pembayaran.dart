import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtkita/app/data/payment.dart';
import 'package:rtkita/app/modules/Manajemen_Iuran/controllers/manajemen_iuran_controller.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/button.dart';
import 'package:rtkita/widgets/text.dart';

class DetailPembayaranView extends StatelessWidget {
  final Payment payment;
  ManajemenIuranController c = Get.put(ManajemenIuranController());
  DetailPembayaranView(this.payment, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(0),
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
                      'Iuran Warga',
                      style: TextStyle(
                        // ignore: unnecessary_const
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CText(
                                  CurrencyFormat.convertToIdr(
                                      int.parse(payment.donationAmount!.replaceAll('Rp. ', '')
                                                      .replaceAll('.', '')), 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                // CText(
                                //   payment.donationAmount!,
                                //   fontSize: 14,
                                //   fontWeight: FontWeight.bold,
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CText(
                              "Tujuan : ${payment.donation!['title']}",
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CText(
                              "Dari : ${payment.familyMember!['family_member_name']}",
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CText(
                              "Tanggal : ${c.convertDate(payment.createdAt!)}",
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CachedNetworkImage(
                                imageUrl:
                                    "https://images.unsplash.com/photo-1593113646773-028c64a8f1b8?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                //  payment.picture!,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, err) {
                                  return Container(
                                      height: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ));
                                }),

                            const SizedBox(
                              height: 24,
                            ),
                            // GetBuilder<DonationController>(
                            //     init: DonationController(),
                            //     builder: (c) {
                            //       return TextField(
                            //         controller: jumlah,
                            //         decoration: InputDecoration(
                            //           border: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10)),
                            //           hintText: 'Jumlah donasi...',
                            //           prefixIcon: const Icon(
                            //               FluentIcons.money_24_regular),
                            //         ),
                            //       );
                            //     }),
                            // const SizedBox(
                            //   height: 24,
                            // ),
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
      ),
    );
  }
}
