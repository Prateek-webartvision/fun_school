import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/courses.model.dart';
import '../../../network/exception/k_exceptions.dart';
import '../../../repo/courses_and_details_repo/courses_and_details_repo.dart';
import '../../../uitls/app_utils.dart';

class FindCourseByCareerController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;
  List<CoursesModel>? _coursesList;
  List<CoursesModel>? filterList;

  // coreer tag
  late Set<String> careerSet;
  int? currentCareerTagIndex;
  // interest tag
  late Set<String> interestSet;

  FindCourseByCareerController() {
    _initLoad();
  }

  _initLoad() async {
    await _getCourses();
    _getCareerSets();
    _getInterestSets();
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

  _getCareerSets() {
    // get sets off career
    if (_coursesList != null) {
      Set<String> tempSet = {};
      for (var element in _coursesList!) {
        tempSet.add(element.courseCareer!);
      }
      careerSet = tempSet;
      if (careerSet.isNotEmpty) {
        currentCareerTagIndex = 0;
      }
      searchFilter();
      update();
    }
  }

  // filter by search
  searchFilter({String? query = ""}) {
    List<CoursesModel> careerData;
    if (currentCareerTagIndex != null) {
      careerData = _filterCareer(careerSet.elementAt(currentCareerTagIndex!));
    } else {
      careerData = _coursesList!;
    }

    List<CoursesModel> tempList = careerData.where((element) => element.courseName!.toLowerCase().contains(query!.toLowerCase().trim())).toList();
    filterList = tempList;
    update();
    // return tempList;
  }

  // filter by career
  List<CoursesModel> _filterCareer(String career) {
    List<CoursesModel> tempList = [];
    if (_coursesList != null) {
      for (var element in _coursesList!) {
        if (element.courseCareer == career) {
          tempList.add(element);
        }
      }
    }
    return tempList;
  }

  // change career tag
  changeCareerTag(int v) {
    currentCareerTagIndex = v;
    searchFilter();
    update();
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    update();
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      List<CoursesModel> data = [];
      for (var element in v) {
        data.add(CoursesModel.fromJson(element));
      }
      // print(v);
      _coursesList = data;
      error = null;
      update();
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
      update();
    });
  }
}
