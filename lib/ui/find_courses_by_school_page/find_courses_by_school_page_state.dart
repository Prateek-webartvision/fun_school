import 'package:flutter/material.dart';

import 'controller/find_courses_by_school_controller.dart';
import 'find_courses_by_school_page.dart';

abstract class FindCoursesBySchoolPageState extends State<FindCoursesBySchoolPageView> {
  late FindCoursesBySchoolController findCoursesBySchoolController;

  @override
  void initState() {
    findCoursesBySchoolController = FindCoursesBySchoolController();
    super.initState();
  }

  @override
  void dispose() {
    findCoursesBySchoolController.dispose();
    super.dispose();
  }
}
