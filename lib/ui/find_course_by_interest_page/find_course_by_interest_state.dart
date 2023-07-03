import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/find_course_by_interest_controller.dart';
import 'find_course_by_interest_view.dart';

abstract class FindCourseByInterestState extends State<FindCourseByInterestView> {
  late FindCourseByInterestController findCourseByInterestController;

  onSearch(String s) => findCourseByInterestController.searchFilter(s);
  onInterest(String? interest) => findCourseByInterestController.interestFilter(interest);
  onLevel(String? level) => findCourseByInterestController.proficiencyFilter(level);

  @override
  void initState() {
    findCourseByInterestController = FindCourseByInterestController();
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
