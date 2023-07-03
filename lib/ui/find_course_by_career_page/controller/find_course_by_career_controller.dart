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
  List<CoursesModel> filterList = [];

  // search text;
  String searchText = "";

  // coreer tag
  late Set<String> careerSet;
  int? currentCareerTagIndex;

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
      for (var element in _coursesList!) {
        tempSet.add(element.courseCareer!);
      }
      careerSet = tempSet;

      if (careerSet.isNotEmpty) {
        currentCareerTagIndex = 0;
      }
      filterList = _finterAllQuerys(
        data: _coursesList!,
        careerTag: careerSet.elementAt(currentCareerTagIndex!),
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
      interest: seletedInterest,
      query: searchText,
      school: null,
    );
    update();
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
  }) {
    List<CoursesModel> careerfilteredData = [];

    if (careerTag != null) {
      List<CoursesModel> tempList = [];
      for (var element in data) {
        if (element.courseCareer == careerTag) {
          tempList.add(element);
        }
      }
      careerfilteredData = tempList;
    }

    if (query.isNotEmpty) {
      List<CoursesModel> tempList = careerfilteredData.where((element) => element.courseName!.toLowerCase().contains(query.toLowerCase().trim())).toList();
      careerfilteredData = tempList;
    }

    if (interest != null) {
      List<CoursesModel> tempList = careerfilteredData.where((element) => element.courseInterest!.toLowerCase().contains(interest.toLowerCase())).toList();
      careerfilteredData = tempList;
    }

    if (schoolLevel != null) {
      List<CoursesModel> tempList = careerfilteredData.where((element) => element.courseSchool!.toLowerCase().contains(schoolLevel!.toLowerCase())).toList();
      careerfilteredData = tempList;
      // print(tempList);
    }

    return careerfilteredData;
  }
}
