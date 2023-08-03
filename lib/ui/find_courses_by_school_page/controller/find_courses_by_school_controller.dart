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
  // List<CoursesModel>? _coursesBySchool;
  List<CoursesModel>? coursesBySearch;

  List<CoursesModel> selectedSubject = [];

  Set<String>? subSchoolSet;
  int subScoolSelectionIndex = 0;

  late SchoolSelectorController schoolSelectorController;

  FindCoursesBySchoolController() {
    _initLoadDate();
  }

  changeCourseSelection(CoursesModel selectedSubject) {
    // this.selectedSubject = selectedSubject;
    print("object");
    if (this.selectedSubject.contains(selectedSubject)) {
      this.selectedSubject.remove(selectedSubject);
    } else {
      this.selectedSubject.add(selectedSubject);
    }
    update();
  }

  _initLoadDate() async {
    await _getCourses();

    schoolSelectorController = SchoolSelectorController(schoolSeletedIndex: 0, coursesList: _coursesList);

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: '',
      sortByQuery: '',
    );
    _setSubSchool();
  }

  onSchoolChange() {
    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: '',
      sortByQuery: '',
    );
    _setSubSchool();

    update();
  }

  _setSubSchool() {
    subScoolSelectionIndex = 0;
    subSchoolSet = coursesBySearch!.map((e) => e.courseSchoolSubCategory!).toSet();

    final subSchool = subSchoolSet!.toList();

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: subSchool[subScoolSelectionIndex],
      sortByQuery: '',
    );
    update();
  }

  changeSubSchoolSet(int index) {
    subScoolSelectionIndex = index;
    final subSchool = subSchoolSet!.toList();

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: subSchool[subScoolSelectionIndex],
      sortByQuery: '',
    );
    update();
  }

  searchSort(String value) {
    final subSchool = subSchoolSet!.toList();

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: subSchool[subScoolSelectionIndex],
      sortByQuery: value,
    );

    update();
  }

  List<CoursesModel> _allSort({required List<CoursesModel> data, required String sortBySchool, required String sortByTag, required String sortByQuery}) {
    List<CoursesModel> filteredData = data;

    // school level filter
    if (sortBySchool.isNotEmpty) {
      List<CoursesModel> tempList = filteredData.where((element) => element.courseSchool == sortBySchool).toList();
      filteredData = tempList;
    }

    //sort by tag
    if (sortByTag.isNotEmpty) {
      List<CoursesModel> tempList = filteredData.where((element) => element.courseSchoolSubCategory == sortByTag).toList();
      filteredData = tempList;
    }

    // search filter
    if (sortByQuery.isNotEmpty) {
      List<CoursesModel> tempList = filteredData.where((element) => element.courseName!.toLowerCase().contains(sortByQuery.toLowerCase().trim())).toList();
      filteredData = tempList;
    }

    return filteredData;
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    await loadWithLoading();
  }

  loadWithLoading() async {
    List<CoursesModel> data = [];
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      for (var element in v) {
        data.add(CoursesModel.fromJson(element));
      }
    }).onError((error, stackTrace) {
      apiState = ApiState.error;
      if (error is KInternetException) {
        AppUtils.showSnack(error.message.toString());
        this.error = error.message.toString();
      }
      if (error is FlutterError) {
        /// this error comw due to call api after disposing controller
        AppUtils.showSnack(error.message);
      } else {
        AppUtils.showSnack(error.runtimeType.toString());
        this.error = error.toString();
      }
    });
    _coursesList = data;
    update();
  }

  @override
  dispose() {
    schoolSelectorController.dispose();
    super.dispose();
  }
}
