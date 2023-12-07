import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/app/modules/midtrans/views/midtrans_view.dart';
import 'package:rtkita/app/modules/tagihan/views/history_view.dart';
import 'package:rtkita/app/providers/tagihan_ipl.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/body_builder.dart';
import 'package:rtkita/widgets/button.dart';
import 'package:rtkita/widgets/text.dart';

import '../controllers/tagihan_controller.dart';

class TagihanView extends GetView<TagihanController> {
  TagihanView({Key? key}) : super(key: key);

  final TagihanProvider tagihanProvider = TagihanProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BodyBuilder(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
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
                            'Pembayaran IPL',
                            style: TextStyle(
                              color: Color(0xff25446F),
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          transform: Matrix4.translationValues(10, 0, 0),
                          child: IconButton(
                            icon: Icon(Icons.history),
                            onPressed: () {
                              Get.to(() => HistoryView());
                            },
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (home) {
                        return home.invoice.isEmpty
                            ? Container()
                            : Container(
                                margin:
                                    const EdgeInsets.only(bottom: 120, top: 12),
                                child: GetBuilder<TagihanController>(
                                  init: TagihanController(),
                                  builder: (c) {
                                    return ListView.builder(
                                      itemCount: home.invoice.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            c.addSelectedIpl(
                                                home.invoice, index);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 15.0,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: c.selectedIpl!
                                                          .contains(home
                                                              .invoice[index]),
                                                      onChanged: (value) {
                                                        c.addSelectedIpl(
                                                            home.invoice,
                                                            index);
                                                      },
                                                    ),
                                                    CText(
                                                      home.invoice[index]
                                                          .invoiceIpl!.date!,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                                CText(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(home
                                                          .invoice[home.invoice
                                                                  .length -
                                                              1]
                                                          .house!
                                                          .invoiceIpl!),
                                                      0),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                  )
                ],
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
                              Expanded(
                                  child: PrimaryButton(
                                      text: 'Pilih Pembayaran',
                                      onTap: () {
                                        Get.to(() => MidtransView(0));
                                      }))
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
      ),
    );
  }
}
