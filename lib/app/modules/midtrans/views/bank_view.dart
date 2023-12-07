import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtkita/app/modules/midtrans/controllers/midtrans_controller.dart';
import 'package:rtkita/app/modules/midtrans/providers/midtrans.dart';
import 'package:rtkita/app/utils/currency_format.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/body_builder.dart';
import 'package:rtkita/widgets/button.dart';
import 'package:rtkita/widgets/text.dart';

class BankView extends GetView {
  final String bank;
  final String codeVa;
  final String? expiry;
  final String orderId;
  final int type;
  final int amount;
  const BankView(
      this.codeVa, this.expiry, this.bank, this.orderId, this.type, this.amount,
      {Key? key})
      : super(key: key);
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
                            'Pembayaran',
                            style: TextStyle(
                              // ignore: unnecessary_const
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CText(
                              'Menunggu Pembayaran',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            const SizedBox(height: 12),
                            CText(
                              'Selesaikan pembayaran sebelum:',
                              fontSize: 14,
                              color: subtextColor,
                            ),
                            CText(expiry == null
                                ? '-'
                                : DateFormat('d MMM y H:mm').format(
                                        DateTime.parse(expiry!)
                                            .add(Duration(hours: 1))) +
                                    ' WITA'),
                            const SizedBox(height: 12),
                            GetBuilder<MidtransController>(
                              init: MidtransController(),
                              builder: (c) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 1),
                                        blurRadius: 15.0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/image/' + bank + '.png',
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          CText(
                                            bank.toUpperCase(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                      CText(
                                        CurrencyFormat.convertToIdr(amount, 0),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const CText(
                              'Salin Kode & Bayar',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SelectableText(
                              codeVa,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                overflow: TextOverflow.ellipsis,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const CText(
                              'Cara Melakukan Pembayaran',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const CText(
                              'ATM',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText('1. Masukkan PIN kartu ATM anda'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '2. Pilih “Transaksi Lainnya”, lalu “Pembayaran” >  “Lainnya” > “Virtual Account”'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '3. Masukkan 16 digit kode pembayaran anda'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '4. Konfirmasi nomor VA, nama nasabah, dan jumlah pembayaran'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '5. Ikuti Instruksi untuk menyelesaikan pembayaran'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '6. Saat transaksi pembayaran selesai, cetak struk dan simpan bukti untuk anda'),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const CText(
                              'Mobile Banking',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText('1. Login ke akun Bank anda'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '2. Pilih “Transaksi Lainnya”, lalu “Pembayaran” >  “Lainnya” > “Virtual Account”'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '3. Masukkan 16 digit kode pembayaran anda'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '4. Konfirmasi nomor VA, nama nasabah, dan jumlah pembayaran'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '5. Ikuti Instruksi untuk menyelesaikan pembayaran'),
                            const SizedBox(
                              height: 8,
                            ),
                            const CText(
                                '6. Saat transaksi pembayaran selesai, cetak struk dan simpan bukti untuk anda'),
                            const SizedBox(
                              height: 90,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: PrimaryButton(
                  text: 'Cek Status Pembayaran',
                  onTap: () {
                    MidtransProvider midtransProvider = MidtransProvider();
                    midtransProvider.checkStatus(
                        context, orderId, type, amount, 1);
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
