import 'package:citycloud_school/ui/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/find_course_by_career_controller.dart';
import 'find_course_by_career_view.dart';

abstract class FindCouresByCareerState extends State<FindCourseByCareerView> {
  late FindCourseByCareerController findCourseByCareerController;
  late SmoothIndicatorController smoothIndicatorController;

  @override
  void initState() {
    findCourseByCareerController = FindCourseByCareerController();
    smoothIndicatorController = SmoothIndicatorController(0);
    Get.lazyPut(() => findCourseByCareerController);
    super.initState();
  }

  searchSubmmit(String query) {
    findCourseByCareerController.searchFilter(query: query);
  }

  @override
  void dispose() {
    findCourseByCareerController.dispose();
    super.dispose();
  }
}
