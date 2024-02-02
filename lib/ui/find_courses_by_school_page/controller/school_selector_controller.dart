import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/courses_details/courses.model.dart';

class SchoolSelectorController extends GetxController {
  int schoolSeletedIndex;
  late String selectionKey;

  late List<SchoolModel> schools = [
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

  SchoolSelectorController(
      {this.schoolSeletedIndex = 0, required List<CoursesModel> coursesList}) {
    _createSchoolList(coursesList);
    selectionKey = schools[schoolSeletedIndex].key;
  }

  _createSchoolList(List<CoursesModel> courses) {
    List<SchoolModel> temp = [];
    Set<String> school = courses.map((e) => e.courseSchool!).toSet();

    for (var element in school) {
      temp.add(SchoolModel(
          name: element.replaceAll("_", " ").capitalize!, key: element));
    }
    schools = temp;
    update();
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
  final IconData? icon;
  final String key;

  SchoolModel({required this.name, this.icon, required this.key});
  @override
  String toString() {
    return "$name, $key";
  }
}
