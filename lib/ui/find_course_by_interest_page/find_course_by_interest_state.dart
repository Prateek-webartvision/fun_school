import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_page/controller/smooth_indicator_controller.dart';
import 'controller/find_course_by_interest_controller.dart';
import 'find_course_by_interest_view.dart';

abstract class FindCourseByInterestState
    extends State<FindCourseByInterestView> {
  late FindCourseByInterestController findCourseByInterestController;
  late SmoothIndicatorController smoothIndicatorController;

  onSearch(String s) => findCourseByInterestController.searchFilter(s);
  onInterest(String? interest) =>
      findCourseByInterestController.interestFilter(interest);
  onLevel(String? level) =>
      findCourseByInterestController.proficiencyFilter(level);

  @override
  void initState() {
    findCourseByInterestController = FindCourseByInterestController();
    smoothIndicatorController = SmoothIndicatorController(0);
    Get.lazyPut(() => findCourseByInterestController);
    super.initState();
  }

  @override
  void dispose() {
    if (findCourseByInterestController.filterList.isNotEmpty) {
      findCourseByInterestController.dispose();
    }
    super.dispose();
  }
}
