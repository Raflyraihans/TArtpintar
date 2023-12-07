import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rtkita/app/data/category_product.dart';
import 'package:rtkita/app/data/product.dart';
import 'package:rtkita/app/providers/produk.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/card_produk.dart';
import 'package:rtkita/widgets/text.dart';

import '../controllers/umkm_controller.dart';

class UmkmView extends GetView<UmkmController> {
  UmkmView({Key? key}) : super(key: key);
  final UmkmProvider p = UmkmProvider();
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
                    'UMKM',
                    style: TextStyle(
                      // ignore: unnecessary_const
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
          Expanded(
            child: SingleChildScrollView(
              child: GetBuilder<UmkmController>(
                init: UmkmController(),
                builder: (c) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                      children: [
                        // TextField(
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10)),
                        //     hintText: 'Cari Produk UMKM...',
                        //     prefixIcon:
                        //         const Icon(FluentIcons.search_24_regular),
                        //   ),
                        // ),
                        SizedBox(
                          height: 77,
                          child: FutureBuilder<List<CategoryProduct?>>(
                            future: p.getListCategory(context),
                            builder: (context, snapshot) {
                              return snapshot.data == null
                                  ? Container()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            c.changeTab(
                                                snapshot.data![index]!.id);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(24),
                                            child: Column(
                                              children: [
                                                CText(
                                                  snapshot
                                                      .data![index]!.category!,
                                                  color: c.selectedTab ==
                                                          snapshot
                                                              .data![index]!.id
                                                      ? primaryColor
                                                      : Colors.grey,
                                                  fontSize: 16,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 1,
                                                  width: 24,
                                                  decoration: BoxDecoration(
                                                      color: c.selectedTab ==
                                                              snapshot
                                                                  .data![index]!
                                                                  .id
                                                          ? primaryColor
                                                          : Colors.transparent),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                          ),
                        ),
                        FutureBuilder<List<Product?>>(
                          future:
                              p.getProductByCategory(context, c.selectedTab),
                          builder: (context, snapshot) {
                            return snapshot.data == null
                                ? Container()
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data == null
                                        ? 0
                                        : snapshot.data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 8.5 / 13.5),
                                    itemBuilder: (context, index) {
                                      return CardProduk(
                                          title: snapshot.data![index]!.title!,
                                          penjual: snapshot.data![index]!
                                                      .familyMember ==
                                                  null
                                              ? 'Penjual'
                                              : snapshot
                                                  .data![index]!
                                                  .familyMember!
                                                  .familyMemberName!,
                                          harga: snapshot.data![index]!.price!,
                                          picture:
                                              snapshot.data![index]!.picture!);
                                    },
                                  );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
