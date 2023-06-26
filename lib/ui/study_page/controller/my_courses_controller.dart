import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../network/exception/k_exceptions.dart';
import '../../../repo/courses_and_details_repo/courses_and_details_repo.dart';
import '../../../uitls/app_utils.dart';

class MyCoursesController extends GetxController {
  late List<CoursesModel> _allCourses;
  List<CoursesModel>? myCourses;
  ApiState apiState = ApiState.loading;
  String? error;

  MyCoursesController() {
    _initDate();
  }

  _initDate() async {
    await _loadAllCourses();
    _sortCoursesForUser();
  }

  _sortCoursesForUser() {
    // print(_allCourses);
    var nonNullCourses = _allCourses.where((element) => element.courseEnrollment!.isNotEmpty).toList();

    // for (var element in nonNullCourses) {
    //   for (var e in element.courseEnrollment!) {
    //     print("id = ${e.userId}");
    //   }
    // }
    var myCourses = nonNullCourses.where((element) {
      final bool;
      for (var e in element.courseEnrollment!) {
        "Kundan $e";
      }
      return true;
    });
    this.myCourses = nonNullCourses;
  }

  _loadAllCourses() async {
    apiState = ApiState.loading;
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      List<CoursesModel> _data = [];
      for (var element in v) {
        _data.add(CoursesModel.fromJson(element));
      }
      _allCourses = _data;
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
}
