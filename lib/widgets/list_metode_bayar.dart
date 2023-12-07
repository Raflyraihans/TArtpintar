import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rtkita/app/modules/midtrans/controllers/midtrans_controller.dart';
import 'package:rtkita/env/color.dart';
import 'package:rtkita/widgets/text.dart';

class ListMetodeBayar extends StatelessWidget {
  final Widget? leading;
  final String text;
  final String description;
  final Widget child;
  const ListMetodeBayar(
      {Key? key,
      this.leading,
      required this.text,
      required this.description,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: subtextColor.withOpacity(0.2), width: 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  leading ?? Container(),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          child,
        ],
      ),
    );
  }
}

class RadioPembayaran extends StatelessWidget {
  final String selectedPembayaran;
  final VoidCallback onTap;
  const RadioPembayaran(
      {Key? key, required this.selectedPembayaran, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MidtransController>(
        init: MidtransController(),
        builder: (c) {
          return InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: subtextColor),
                    ),
                    child:
                        c.selectedPembayaran == selectedPembayaran.toLowerCase()
                            ? Center(
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor),
                                ),
                              )
                            : Container(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  selectedPembayaran == 'Lainnya'
                      ? Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.more_horiz,
                          ),
                        )
                      : Image.asset(
                          'assets/image/${selectedPembayaran.toLowerCase()}.png'),
                  const SizedBox(
                    width: 8,
                  ),
                  CText(
                    selectedPembayaran,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
          );
        });
  }
}
