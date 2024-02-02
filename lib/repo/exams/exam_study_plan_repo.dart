import 'package:citycloud_school/models/exams/exam_study_plan_models/course_name_model.dart';
import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/exams/exam_study_plan_models/exam_study_plan_model.dart';

class ExamStudyPlanRepository {
  static final _api = AppApi();

  static Future<List<ExamStudyPlanModel>> getStudyPlans() async {
    return await _api.getApi(AppUrls.examStudyPlans).then((value) {
      List<ExamStudyPlanModel> temp = [];
      for (var element in value) {
        final plan = ExamStudyPlanModel.fromJson(element);
        temp.add(plan);
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  static Future<List<CoursesName>> getStudyPlanCoursesList() async {
    return await _api.getApi(AppUrls.getExamCoursesList).then((value) {
      List<CoursesName> temp = [];
      for (var element in value) {
        final course = CoursesName.fromJson(element);
        temp.add(course);
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // add to study plan
  static Future addStudyPlan({
    required String examName,
    required DateTime examDate,
    required List<CoursesName> courses,
    required String studyHour,
    required String periods,
    required String reminder,
    required TimeOfDay reminderTime,
  }) async {
    Map<String, dynamic> prms = {};
    prms['exam_name'] = examName;
    prms['date_of_exam'] = DateFormat("yyyy-MM-dd").format(examDate).toString();
    prms['exam_course'] = courses.map((e) => e.id).toList().toString();
    prms['study_hours'] = studyHour;
    prms['study_periods'] = periods;
    prms['reminder_settings'] =
        "$reminder at ${reminderTime.format(rootNavigator.currentContext!)}";

    return await _api
        .postApi(AppUrls.examAddStudyPlan, params: prms)
        .then((value) {
      if (value['code'] == 200) {
        return value['message'];
      } else {
        throw value['message'];
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
