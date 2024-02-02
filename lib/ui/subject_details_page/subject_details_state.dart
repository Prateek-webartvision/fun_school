import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/courses_dedails/courses.model.dart';
import '../../models/courses_dedails/subject.model.dart';
import '../../repo/enroll_courses_repo/enroll_course_repo.dart';
import '../../utils/app_utils.dart';
import 'subject_details_view.dart';

abstract class SubjectDetailsState extends State<SubjectDetailsView>
    with TickerProviderStateMixin {
  late SubjectDetailsPageController subjectDetailsPageController;
  late List<CoursesSubject> subjects;
  late TabController pageTabController;

  @override
  void initState() {
    subjectDetailsPageController =
        SubjectDetailsPageController(courseData: widget.courseData);

    if (subjectDetailsPageController.courseData != null) {
      subjects = subjectDetailsPageController.courseData!.courseSubjects!;
    } else {
      subjects = [];
    }
    pageTabController = TabController(length: subjects.length, vsync: this);

    super.initState();
  }

  onEnrollClick(bool isEnrolled) async {
    // print(widget.courseData!.isCourseEnrolled.toString());
    if (isEnrolled == false) {
      await AppUtils.showLoadingOverlay(() async {
        await EnrollCoursesRepository.enrollCourse(widget.courseData!.courseId)
            .then((value) {
          if (value == 200) {
            subjectDetailsPageController.enroll(!isEnrolled);
          }
        });
      });
    } else {
      AppUtils.showSnack("Already Enrolled");
    }
  }

  @override
  void dispose() {
    pageTabController.dispose();
    super.dispose();
  }
}

class SubjectDetailsPageController extends GetxController {
  late CoursesModel? courseData;

  SubjectDetailsPageController({required this.courseData});

  enroll(bool v) {
    if (courseData != null) {
      courseData!.isCourseEnrolled = v;
      update();
    }
  }
}
