// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:rtkita/app/data/invoice.dart';

class TagihanController extends GetxController {
  List<Invoice?>? selectedIpl = [];
  int total_tagihan = 0;
  String tagihan_id = '';

  void addSelectedIpl(List<Invoice?>? value, index) {
    selectedIpl!.clear();
    total_tagihan = 0;
    tagihan_id = '';

    var i = 0;
    while (i < index + 1) {
      selectedIpl!.add(value![i]);
      i++;
    }

    for (var v in selectedIpl!) {
      total_tagihan = total_tagihan + int.parse(v!.house!.invoiceIpl!);
      tagihan_id = tagihan_id == '' ? '${v.id},' : '$tagihan_id${v.id},';
    }
    tagihan_id = tagihan_id.substring(0, tagihan_id.length - 1);
    update();
  }

  void addDonasi(jumlah, id) {
    total_tagihan = int.parse(jumlah);
    tagihan_id = id.toString();
    update();
  }
}
