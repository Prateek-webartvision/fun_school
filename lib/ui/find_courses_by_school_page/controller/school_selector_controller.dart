import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSelectorController extends GetxController {
  int schoolSeletedIndex;
  late String selectionKey;

  final List<SchoolModel> schools = [
    SchoolModel(
      name: "Junior secondary school",
      icon: Icons.account_balance_sharp,
      key: "junior_secondary",
    ),
    SchoolModel(
      name: "Senior secondary school",
      icon: Icons.business_outlined,
      key: "senior_secondary",
    ),
    SchoolModel(
      name: "University",
      icon: Icons.temple_buddhist_outlined,
      key: "university",
    ),
  ];

  SchoolSelectorController({this.schoolSeletedIndex = 0}) {
    selectionKey = schools[schoolSeletedIndex].key;
  }

  changeSchool(int index) {
    if (schoolSeletedIndex != index) {
      schoolSeletedIndex = index;
      selectionKey = schools[schoolSeletedIndex].key;
      update();
    }
  }
}

class SchoolModel {
  final String name;
  final IconData icon;
  final String key;

  SchoolModel({required this.name, required this.icon, required this.key});
}
