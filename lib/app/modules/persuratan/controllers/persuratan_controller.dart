import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtkita/app/data/family_member.dart';

import '../../../data/cover_letter.dart';

class PersuratanController extends GetxController {
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController deskripsiSurat = TextEditingController();

  List<FamilyMember?> familyMember = [];
  List<CoverLetter?>? coverLetter;
  FamilyMember? selectedFamilyMember;

  setFamilyMember(List<FamilyMember?> data) {
    familyMember = data;
    update();
  }

  setCoverLetter(List<CoverLetter?> data) {
    coverLetter = data;
    update();
  }

  selectFamilyMember(FamilyMember? data) {
    selectedFamilyMember = data;
    namaLengkap.text = data!.familyMemberName!;
    update();
  }
}
