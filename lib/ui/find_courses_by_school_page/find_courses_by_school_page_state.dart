import 'package:flutter/material.dart';

import 'controller/find_courses_by_school_controller.dart';
import 'find_courses_by_school_page_view.dart';

abstract class FindCoursesBySchoolPageState extends State<FindCoursesBySchoolPageView> {
  late FindCoursesBySchoolController findCoursesBySchoolController;

  @override
  void initState() {
    try {
      findCoursesBySchoolController = FindCoursesBySchoolController();
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    if (findCoursesBySchoolController.coursesBySchool != null) {
      findCoursesBySchoolController.dispose();
    }
    super.dispose();
  }
}
