import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_page/home_page.dart';
import 'controller/find_courses_by_school_controller.dart';
import 'find_courses_by_school_page_view.dart';

abstract class FindCoursesBySchoolPageState extends State<FindCoursesBySchoolPageView> {
  late FindCoursesBySchoolController findCoursesBySchoolController;
  late SmoothIndicatorController smoothIndicatorTipController;

  @override
  void initState() {
    findCoursesBySchoolController = FindCoursesBySchoolController();
    smoothIndicatorTipController = SmoothIndicatorController(0);
    Get.lazyPut(() => findCoursesBySchoolController);

    super.initState();
  }

  @override
  void dispose() {
    if (findCoursesBySchoolController.coursesBySearch != null) {
      findCoursesBySchoolController.dispose();
    }
    super.dispose();
  }
}
