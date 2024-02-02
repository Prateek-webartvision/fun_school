import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/courses.model.dart';
import '../../../network/exception/k_exceptions.dart';
import '../../../repo/courses_and_details_repo/courses_and_details_repo.dart';
import '../../../utils/app_utils.dart';

class FindCourseByInterestController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;

  List<CoursesModel>? _coursesList;
  List<CoursesModel> filterList = [];
  List<CoursesModel> selectedSubject = [];

  // sets
  late Set<String> interestSet;
  int? interestindex;
  late Set<String> proficiencySet;

  // filters
  String searchQuery = "";
  String? interestQuery;
  String? proficiencyLevel;

  FindCourseByInterestController() {
    _iniLoadData();
  }

  _iniLoadData() async {
    await _getCourses();
    filterList = _finterAllQuerys(data: _coursesList!);
    _loadSetData();
  }

  updateEnrollers(CoursesModel item) {
    item.isCourseEnrolled = !item.isCourseEnrolled;
    update();
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

  //loadSets
  _loadSetData() {
    Set<String> interestSet = {};
    Set<String> proficiencySet = {};

    if (_coursesList != null) {
      for (var element in _coursesList!) {
        interestSet.add(element.courseInterest!);
        proficiencySet.add(element.courseProficiency!);
      }
    }

    this.interestSet = interestSet;
    if (this.interestSet.isNotEmpty) {
      interestindex = 0;
    }
    this.proficiencySet = proficiencySet;
  }

  //searchFilter
  searchFilter(String v) {
    searchQuery = v;
    filterList = _finterAllQuerys(
      data: _coursesList!,
      query: searchQuery,
      interest: interestQuery,
      proficiencyLevel: proficiencyLevel,
    );
    update();
  }

  // interest filter
  interestFilter(String? interest) {
    interestindex = interestSet.toList().indexOf(interest ?? "");
    interestQuery = interest;
    filterList = _finterAllQuerys(
      data: _coursesList!,
      query: searchQuery,
      interest: interestQuery,
      proficiencyLevel: proficiencyLevel,
    );
    update();
  }

  // level filter
  proficiencyFilter(String? level) {
    proficiencyLevel = level;
    filterList = _finterAllQuerys(
      data: _coursesList!,
      query: searchQuery,
      interest: interestQuery,
      proficiencyLevel: proficiencyLevel,
    );
    update();
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    await loadWithLoading();
  }

  loadWithLoading() async {
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      List<CoursesModel> data = [];
      for (var element in v) {
        data.add(CoursesModel.fromJson(element));
      }
      // print(v);
      _coursesList = data;
      error = null;
    }).onError((error, stackTrace) {
      apiState = ApiState.error;
      if (error is KInternetException) {
        AppUtils.showSnack(error.message.toString());
        this.error = error.message.toString();
      }
      if (error is FlutterError) {
        /// this error comw due to call api after disposing controller
        AppUtils.showSnack("Got Error");
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
    String? interest,
    String? proficiencyLevel,
  }) {
    List<CoursesModel> careerfilteredData = data;

    // search filter
    if (query.isNotEmpty) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseName!
              .toLowerCase()
              .contains(query.toLowerCase().trim()))
          .toList();
      careerfilteredData = tempList;
    }

    // interest filter
    if (interest != null) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseInterest!
              .toLowerCase()
              .contains(interest.toLowerCase()))
          .toList();
      careerfilteredData = tempList;
    }

    // proficiency level filter
    if (proficiencyLevel != null) {
      List<CoursesModel> tempList = careerfilteredData
          .where((element) => element.courseProficiency!
              .toLowerCase()
              .contains(proficiencyLevel.toLowerCase()))
          .toList();
      careerfilteredData = tempList;
      // print(tempList);
    }

    return careerfilteredData;
  }
}
