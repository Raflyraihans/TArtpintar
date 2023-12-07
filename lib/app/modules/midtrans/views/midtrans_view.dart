import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/modules/midtrans/providers/midtrans.dart';
import 'package:rtkita/app/modules/tagihan/controllers/tagihan_controller.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/body_builder.dart';
import 'package:rtkita/widgets/button.dart';
import 'package:rtkita/widgets/list_metode_bayar.dart';
import 'package:rtkita/widgets/text.dart';

import '../controllers/midtrans_controller.dart';

class MidtransView extends GetView<MidtransController> {
  final int type;
  MidtransView(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BodyBuilder(
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
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
                            'Pilih Metode Pembayaran',
                            style: TextStyle(
                              // ignore: unnecessary_const
                              color: Color(0xff25446F),
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
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
                      child: GetBuilder<MidtransController>(
                        init: MidtransController(),
                        builder: (c) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<TagihanController>(
                                    init: TagihanController(),
                                    builder: (tagihan) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 24),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 1),
                                              blurRadius: 15.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  'Total Bayar',
                                                  color: subtextColor,
                                                ),
                                                CText(
                                                  CurrencyFormat.convertToIdr(
                                                      tagihan.total_tagihan, 0),
                                                  fontWeight: FontWeight.w600,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  'Payment ID',
                                                  color: subtextColor,
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: CText(
                                                    tagihan.tagihan_id,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                const SizedBox(
                                  height: 8,
                                ),
                                const CText(
                                  'Metode Pembayaran',
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                // ListMetodeBayar(
                                //   leading: Image.asset(
                                //     'assets/image/wallet.png',
                                //     fit: BoxFit.cover,
                                //   ),
                                //   text: 'E-Wallet',
                                //   description:
                                //       'Bayar instan dan mudah dengan\ne-wallet',
                                //   child: Column(
                                //     children: [
                                //       RadioPembayaran(
                                //           selectedPembayaran: 'GoPay',
                                //           onTap: () {
                                //             c.selectPembayaran('gopay');
                                //           }),
                                //     ],
                                //   ),
                                // ),
                                ListMetodeBayar(
                                  leading: Image.asset(
                                    'assets/image/transfer.png',
                                    fit: BoxFit.cover,
                                  ),
                                  text: 'Transfer Bank',
                                  description:
                                      'Bayar dengan transfer antar bank\nyang anda inginkan',
                                  child: Column(
                                    children: [
                                      RadioPembayaran(
                                        selectedPembayaran: 'BRI',
                                        onTap: () {
                                          c.selectPembayaran('bri');
                                        },
                                      ),
                                      RadioPembayaran(
                                        selectedPembayaran: 'BNI',
                                        onTap: () {
                                          c.selectPembayaran('bni');
                                        },
                                      ),
                                      RadioPembayaran(
                                        selectedPembayaran: 'BCA',
                                        onTap: () {
                                          c.selectPembayaran('bca');
                                        },
                                      ),
                                      RadioPembayaran(
                                        selectedPembayaran: 'Lainnya',
                                        onTap: () {
                                          c.selectPembayaran('lainnya');
                                        },
                                      ),
                                      // RadioPembayaran(
                                      //   selectedPembayaran: 'Permata',
                                      //   onTap: () {
                                      //     c.selectPembayaran('permata');
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                                // ListMetodeBayar(
                                //   leading: Image.asset(
                                //     'assets/image/gerai.png',
                                //     fit: BoxFit.cover,
                                //   ),
                                //   text: 'Gerai',
                                //   description:
                                //       'Bayar ke gerai terdekat\ndari anda',
                                //   child: Column(
                                //     children: [
                                //       RadioPembayaran(
                                //         selectedPembayaran: 'Indomaret',
                                //         onTap: () {
                                //           c.selectPembayaran('indomaret');
                                //         },
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 150,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GetBuilder<TagihanController>(
                init: TagihanController(),
                builder: (c) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CText(
                                    'Total',
                                    color: subtextColor,
                                  ),
                                  CText(
                                    CurrencyFormat.convertToIdr(
                                        c.total_tagihan, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            GetBuilder<MidtransController>(
                              init: MidtransController(),
                              builder: (midtrans) {
                                return Expanded(
                                    child: PrimaryButton(
                                        text: 'Bayar Sekarang',
                                        onTap: () {
                                          final MidtransProvider
                                              midtransProvider =
                                              MidtransProvider();
                                          if (midtrans.selectedPembayaran !=
                                              '') {
                                            if (type == 0) {
                                              midtransProvider.storeMidtrans(
                                                  context,
                                                  '',
                                                  c.tagihan_id,
                                                  c.total_tagihan,
                                                  midtrans.selectedPembayaran,
                                                  type);
                                            } else {
                                              midtransProvider.storeMidtrans(
                                                  context,
                                                  c.tagihan_id,
                                                  '',
                                                  c.total_tagihan,
                                                  midtrans.selectedPembayaran,
                                                  type);
                                            }
                                          }
                                        }));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
