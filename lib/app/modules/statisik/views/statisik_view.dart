import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/app/utils/statistic_data.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/body_builder.dart';
import 'package:rtkita/widgets/statistik_item.dart';
import 'package:rtkita/widgets/text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/statisik_controller.dart';

class StatisikView extends GetView<StatisikController> {
  const StatisikView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<StatisikController>(
          init: StatisikController(),
          builder: (c) {
            return BodyBuilder(
              child: SafeArea(
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
                              'Statistik',
                              style: TextStyle(
                                color: Color(0xff25446F),
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
                    c.statistik == null
                        ? Container()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CText(
                                      'Progres Pembayaran IPL:',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Container(
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
                                                child: Row(
                                                  children: [
                                                    CText(
                                                      '${c.statistik!.progressBar!}%',
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: LayoutBuilder(
                                                          builder: (context,
                                                              constraints) {
                                                        return Container(
                                                          width: (c.statistik!
                                                                      .progressBar! /
                                                                  100) *
                                                              constraints
                                                                  .maxWidth,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 15),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: secondaryColor
                                                                .withOpacity(
                                                                    0.3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // CText(c.statistik!
                                        //         .jumlahProgresIpl!['paid'] +
                                        //     '/' +
                                        //     c.statistik!
                                        //         .jumlahProgresIpl!['total']),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    const CText(
                                      'Statistik Pemasukan/Pengeluaran RT:',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 200,
                                            child: SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                isVisible: true,
                                                labelStyle: const TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              series: <
                                                  LineSeries<IPLData, String>>[
                                                LineSeries<IPLData, String>(
                                                    color: Colors.green,
                                                    dataSource: <IPLData>[
                                                      IPLData(
                                                          'Jan',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .januari
                                                              .toString())),
                                                      IPLData(
                                                          'Feb',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .februari
                                                              .toString())),
                                                      IPLData(
                                                          'Mar',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .maret
                                                              .toString())),
                                                      IPLData(
                                                          'Apr',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .april
                                                              .toString())),
                                                      IPLData(
                                                          'Mei',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .mei
                                                              .toString())),
                                                      IPLData(
                                                          'Jun',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .juni
                                                              .toString())),
                                                      IPLData(
                                                          'Jul',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .juli
                                                              .toString())),
                                                      IPLData(
                                                          'Agu',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .agustus
                                                              .toString())),
                                                      IPLData(
                                                          'Sep',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .september
                                                              .toString())),
                                                      IPLData(
                                                          'Okt',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .oktober
                                                              .toString())),
                                                      IPLData(
                                                          'Nov',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .november
                                                              .toString())),
                                                      IPLData(
                                                          'Des',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticDebit!
                                                              .desember
                                                              .toString())),
                                                    ],
                                                    xValueMapper:
                                                        (IPLData sales, _) =>
                                                            sales.month,
                                                    yValueMapper:
                                                        (IPLData sales, _) =>
                                                            sales.value),
                                                LineSeries<IPLData, String>(
                                                    color:
                                                        const Color(0xffEC9006),
                                                    dataSource: <IPLData>[
                                                      IPLData(
                                                          'Jan',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .januari
                                                              .toString())),
                                                      IPLData(
                                                          'Feb',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .februari
                                                              .toString())),
                                                      IPLData(
                                                          'Mar',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .maret
                                                              .toString())),
                                                      IPLData(
                                                          'Apr',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .april
                                                              .toString())),
                                                      IPLData(
                                                          'Mei',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .mei
                                                              .toString())),
                                                      IPLData(
                                                          'Jun',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .juni
                                                              .toString())),
                                                      IPLData(
                                                          'Jul',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .juli
                                                              .toString())),
                                                      IPLData(
                                                          'Agu',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .agustus
                                                              .toString())),
                                                      IPLData(
                                                          'Sep',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .september
                                                              .toString())),
                                                      IPLData(
                                                          'Okt',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .oktober
                                                              .toString())),
                                                      IPLData(
                                                          'Nov',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .november
                                                              .toString())),
                                                      IPLData(
                                                          'Des',
                                                          double.parse(c
                                                              .statistik!
                                                              .statisticCredit!
                                                              .desember
                                                              .toString())),
                                                    ],
                                                    xValueMapper:
                                                        (IPLData sales, _) =>
                                                            sales.month,
                                                    yValueMapper:
                                                        (IPLData sales, _) =>
                                                            sales.value)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 3,
                                                  width: 10,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                const CText(
                                                  'Pemasukan',
                                                  fontSize: 11,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 3,
                                                  width: 10,
                                                  color:
                                                      const Color(0xffEC9006),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                const CText(
                                                  'Pengeluaran',
                                                  fontSize: 11,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const CText(
                                      'Saldo Akhir Per Bulan: Oktober',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CText(
                                      c.statistik!.lastMonth == null
                                          ? '-'
                                          : CurrencyFormat.convertToIdr(
                                              int.parse(c.statistik!.lastMonth!
                                                  .totalSaldo!),
                                              0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const CText(
                                      'Data Jumlah Warga',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StatistikItem(
                                            icon: FluentIcons.people_20_filled,
                                            title: 'Warga',
                                            subtitle:
                                                '${c.statistik!.countPeople} Orang',
                                            iconColor: Colors.black),
                                        StatistikItem(
                                            icon:
                                                FluentIcons.document_20_filled,
                                            title: 'Kartu Keluarga',
                                            subtitle: c
                                                .statistik!.countFamilyCard!
                                                .toString(),
                                            iconColor: Colors.black),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const CText(
                                      'Data Jenis Kelamin',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StatistikItem(
                                            icon: Icons.male,
                                            title: 'Laki laki',
                                            subtitle:
                                                '${c.statistik!.countMan!} Orang',
                                            iconColor: Colors.green),
                                        StatistikItem(
                                            icon: Icons.female,
                                            title: 'Perempuan',
                                            subtitle:
                                                '${c.statistik!.countWoman!} Orang',
                                            iconColor: const Color(0xffFFA8A7)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const CText(
                                      'Jumlah Data Rumah',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StatistikItem(
                                            icon: FluentIcons.home_20_filled,
                                            title: 'Rumah Terisi',
                                            subtitle: c.statistik!.homeActive!
                                                .toString(),
                                            iconColor: Colors.black),
                                        StatistikItem(
                                            icon: FluentIcons.home_20_regular,
                                            title: 'Rumah Kosong',
                                            subtitle: c.statistik!.homeUnactive!
                                                .toString(),
                                            iconColor: Colors.black),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
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
          }),
    );
  }
}
