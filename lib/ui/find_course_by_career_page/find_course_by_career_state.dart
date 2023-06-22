import 'package:flutter/material.dart';

import 'controller/find_course_by_career_controller.dart';
import 'find_course_by_career_view.dart';

abstract class FindCouresByCareerState extends State<FindCourseByCareerView> {
  late FindCourseByCareerController findCourseByCareerController;

  @override
  void initState() {
    findCourseByCareerController = FindCourseByCareerController();
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
