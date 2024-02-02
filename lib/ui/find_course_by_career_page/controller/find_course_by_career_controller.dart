import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_details/courses.model.dart';
import '../../../network/exception/k_exceptions.dart';
import '../../../repo/courses_and_details_repo/courses_and_details_repo.dart';
import '../../../utils/app_utils.dart';

class FindCourseByCareerController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;

  List<CoursesModel>? _coursesList;
  List<CoursesModel> filterList = [];
  List<CoursesModel> selectedSubject = [];

  // search text;
  String searchText = "";

  // coreer tag
  late Set<String> careerSet;
  int? currentCareerTagIndex;
  late Set<String> proficiencySet;
  int? currentProficiencyTagIndex;

  // interest tag
  late Set<String> interestSet;
  String? seletedInterest;

  // school level
  String? schoolLevel;

  FindCourseByCareerController() {
    _initLoad();
  }

  _initLoad() async {
    await _getCourses();
    _getCareerSets();
    _getInterestSets();
  }

  changeCourseSelection(CoursesModel selectedSubject) {
    // this.selectedSubject = selectedSubject;
    // print("object");
    if (this.selectedSubject.contains(selectedSubject)) {
      this.selectedSubject.remove(selectedSubject);
    } else {
      this.selectedSubject.add(selectedSubject);
    }
    update();
  }

  updateEnrollers(CoursesModel item) {
    item.isCourseEnrolled = !item.isCourseEnrolled;
    update();
  }

  // get sets off interest
  _getInterestSets() {
    if (_coursesList != null) {
      Set<String> tempSet = {};

      for (var element in _coursesList!) {
        tempSet.add(element.courseInterest!);
      }
      interestSet = tempSet;

      update();
    }
  }

  // get sets off career
  _getCareerSets() {
    if (_coursesList != null) {
      Set<String> tempSet = {};
      Set<String> proficiencyTempSet = {};

      for (var element in _coursesList!) {
        tempSet.add(element.courseCareer!);
        proficiencyTempSet.add(element.courseProficiency!);
      }
      careerSet = tempSet;
      proficiencySet = proficiencyTempSet;
      //

      if (careerSet.isNotEmpty) {
        currentCareerTagIndex = 0;
      }
      if (proficiencySet.isNotEmpty) {
        currentProficiencyTagIndex = 0;
      }

      // filter list
      filterList = _finterAllQuerys(
        data: _coursesList!,
        careerTag: careerSet.elementAt(currentCareerTagIndex!),
        proficiency: proficiencySet.elementAt(currentProficiencyTagIndex!),
      );

      update();
    }
  }

  // filter by search
  searchFilter({String? query = ""}) {
    searchText = query!;
    filterList = _finterAllQuerys(
      data: _coursesList!,
      query: searchText,
      careerTag: careerSet.elementAt(currentCareerTagIndex!),
      interest: seletedInterest,
    );
    update();
  }

  // change career tag
  changeCareerTag(int v) {
    currentCareerTagIndex = v;
    seletedInterest = null;
    schoolLevel = null;

    filterList = _finterAllQuerys(
      data: _coursesList!,
      careerTag: careerSet.elementAt(currentCareerTagIndex!),
      proficiency: proficiencySet.elementAt(currentProficiencyTagIndex!),
      interest: seletedInterest,
      query: searchText,
      school: null,
    );
    update();
  }

  // change proficiency Tag
  changeProficiencyTag(int i) {
    if (currentProficiencyTagIndex != i) {
      currentProficiencyTagIndex = i;

      filterList = _finterAllQuerys(
        data: _coursesList!,
        careerTag: careerSet.elementAt(currentCareerTagIndex!),
        query: searchText,
        proficiency: proficiencySet.elementAt(currentProficiencyTagIndex!),
      );
      update();
    }
  }

  // chnage Interest tag
  changeInterestTag(String? interest) {
    seletedInterest = interest;
    filterList = _finterAllQuerys(
      data: _coursesList!,
      careerTag: careerSet.elementAt(currentCareerTagIndex!),
      query: searchText,
      interest: seletedInterest,
    );
    update();
  }

  //change school lavel
  changeSchoolLavel(String? level) {
    schoolLevel = level;
    filterList = _finterAllQuerys(
      data: _coursesList!,
      query: searchText,
      careerTag: careerSet.elementAt(currentCareerTagIndex!),
      interest: seletedInterest,
      school: schoolLevel,
    );
    update();
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    await loadWithLoading();
  }

  loadWithLoading() async {
    await CoursesAndDetailsRepository.getCoursesAndDetails.then((v) {
      apiState = ApiState.success;
      // List<CoursesModel> data = [];
      // for (var element in v) {
      //   data.add(CoursesModel.fromJson(element));
      // }
      // // print(v);
      _coursesList = v;
      error = null;
    }).onError((error, stackTrace) {
      apiState = ApiState.error;
      if (error is KInternetException) {
        AppUtils.showSnack(error.message.toString());
        this.error = error.message.toString();
      }
      if (error is FlutterError) {
        /// this error comw due to call api after disposing controller
        AppUtils.showSnack("gotcha");
      } else {
        AppUtils.showSnack(error.runtimeType.toString());
        this.error = error.toString();
      }
    });
    update();
  }

  // helper Fun for query
  List<CoursesModel> _finterAllQuerys({
    required List<CoursesModel> data,
    String query = "",
    String? careerTag,
    String? interest,
    String? school,
    String? proficiency,
  }) {
    List<CoursesModel> careerfilteredData = data;

    if (careerTag != null) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseCareer == careerTag)
          .toList();
      careerfilteredData = tempList;
    }

    if (proficiency != null) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseProficiency == proficiency)
          .toList();
      careerfilteredData = tempList;
    }

    if (query.isNotEmpty) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseName!
              .toLowerCase()
              .contains(query.toLowerCase().trim()))
          .toList();
      careerfilteredData = tempList;
    }

    if (interest != null) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseInterest!
              .toLowerCase()
              .contains(interest.toLowerCase()))
          .toList();
      careerfilteredData = tempList;
    }

    if (schoolLevel != null) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseSchool!
              .toLowerCase()
              .contains(schoolLevel!.toLowerCase()))
          .toList();
      careerfilteredData = tempList;
    }

    return careerfilteredData;
  }
}
