import 'package:citycloud_school/repo/enroll_courses_repo/enroll_course_repo.dart';
import 'package:citycloud_school/ui/find_course_by_career_page/controller/find_course_by_career_controller.dart';
import 'package:citycloud_school/ui/find_course_by_interest_page/controller/find_course_by_interest_controller.dart';
import 'package:citycloud_school/ui/find_courses_by_school_page/controller/find_courses_by_school_controller.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/courses_dedails/subject.model.dart';
import 'subject_details_view.dart';

abstract class SubjectDetailsState extends State<SubjectDetailsView> with TickerProviderStateMixin {
  late List<CoursesSubject> subjects;
  late TabController pageTabController;
  late var controller;

  @override
  void initState() {
    if (widget.courseData != null) {
      subjects = widget.courseData!.courseSubjects!;
    } else {
      subjects = [];
    }
    pageTabController = TabController(length: subjects.length, vsync: this);

    // pageTabController.addListener(() {
    //   print(pageTabController.index);
    // });

    if (Get.isRegistered<FindCoursesBySchoolController>() == true) {
      controller = Get.find<FindCoursesBySchoolController>();
    } else if (Get.isRegistered<FindCourseByCareerController>()) {
      controller = Get.find<FindCourseByCareerController>();
    } else {
      controller = Get.find<FindCourseByInterestController>();
    }

    super.initState();
  }

  onEnrollClick() async {
    await AppUtils.showloadingOverlay(() async {
      await EnrollCoursesRepository.enrollCourse(widget.courseData!.courseId);
    });

    controller.loadWithLoading();
  }

  @override
  void dispose() {
    pageTabController.dispose();
    super.dispose();
  }
}
