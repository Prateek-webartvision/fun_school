import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/network/exception/k_exceptions.dart';
import 'package:citycloud_school/repo/courses_and_details_repo/courses_and_details_repo.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import 'school_selector_controller.dart';

class FindCoursesBySchoolController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;

  List<CoursesModel> _coursesList = [];
  List<CoursesModel>? _coursesBySchool;
  List<CoursesModel>? coursesBySearch;

  CoursesModel? selectedSubject;

  late SchoolSelectorController schoolSelectorController;

  FindCoursesBySchoolController() {
    schoolSelectorController = SchoolSelectorController(schoolSeletedIndex: 0);
    _initLoadDate();
  }

  changeCourseSelection(CoursesModel selectedSubject) {
    this.selectedSubject = selectedSubject;
    update();
  }

  _initLoadDate() async {
    await _getCourses();
    _sortBySchool(schoolSelectorController.selectionKey);

    schoolSelectorController.addListener(() {
      _sortBySchool(schoolSelectorController.selectionKey);
    });
  }

  // sort by school
  _sortBySchool(String sortby) async {
    List<CoursesModel> _sortData = [];
    if (_coursesList.isNotEmpty) {
      for (var element in _coursesList) {
        if (element.courseSchool == sortby) {
          _sortData.add(element);
        }
      }
    }
    // print(_sortData);
    _coursesBySchool = _sortData;
    searchSort("");
    // update();
  }

  searchSort(String value) {
    if (_coursesBySchool != null) {
      coursesBySearch = _coursesBySchool!.where((element) => element.courseName!.toLowerCase().contains(value.toString())).toList();
      update();
    }
    // print("object");
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    await loadWithLoading();
  }

  loadWithLoading() async {
    List<CoursesModel> _data = [];
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      for (var element in v) {
        _data.add(CoursesModel.fromJson(element));
      }
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
    _coursesList = _data;
    update();
  }

  @override
  dispose() {
    schoolSelectorController.dispose();
    super.dispose();
  }
}
