import 'package:citycloud_school/repo/enroll_courses_repo/enroll_course_repo.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';

import '../../models/courses_dedails/subject.model.dart';
import 'subject_details_view.dart';

abstract class SubjectDetailsState extends State<SubjectDetailsView> with TickerProviderStateMixin {
  late List<CoursesSubject> subjects;
  late TabController pageTabController;

  @override
  void initState() {
    if (widget.courseData != null) {
      subjects = widget.courseData!.courseSubjects!;
    } else {
      subjects = [];
    }
    pageTabController = TabController(length: subjects.length, vsync: this);

    super.initState();
  }

  onEnrollClick() async {
    await AppUtils.showloadingOverlay(() async {
      await EnrollCoursesRepository.enrollCourse(widget.courseData!.courseId);
    });
  }

  @override
  void dispose() {
    pageTabController.dispose();
    super.dispose();
  }
}
