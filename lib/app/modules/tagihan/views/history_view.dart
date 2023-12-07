import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/modules/tagihan/controllers/history_controller.dart';
import 'package:rtkita/app/modules/tagihan/providers/riwayat.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/body_builder.dart';
import 'package:rtkita/widgets/button.dart';
import 'package:rtkita/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryView extends GetView {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBuilder(
        child: SafeArea(
          child: GetBuilder<HistoryController>(
              init: HistoryController(),
              initState: (state) {
                final RiwayatTagihanProvider riwayatTagihanProvider =
                    RiwayatTagihanProvider();
                riwayatTagihanProvider.getListMidtrans();
              },
              builder: (c) {
                return Column(
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
                              'Riwayat Pembayaran IPL',
                              style: TextStyle(
                                color: Color(0xff25446F),
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: c.midtrans!.length,
                        itemBuilder: (context, index) {
                          String bulan = '';
                          c.midtrans![index]['midtrans_donation_ipls'].forEach(
                              (v) => bulan = bulan +
                                  v['house_invoice_ipl']['invoice_ipl']
                                      ['date'] +
                                  ', ');
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 1),
                                    blurRadius: 15.0),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  'Pembayaran IPL',
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CText(
                                  bulan,
                                  color: subtextColor,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CText(
                                        CurrencyFormat.convertToIdr(
                                            int.parse(
                                                c.midtrans![index]['total']),
                                            0),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      width: 140,
                                      child: PrimaryButton(
                                          text: 'Unduh Bukti Bayar',
                                          onTap: () {
                                            launchUrl(
                                                Uri.parse(
                                                    'https://rtkita.imagi.id/receipt?id=' +
                                                        c.midtrans![index]['id']
                                                            .toString()),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          }),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
