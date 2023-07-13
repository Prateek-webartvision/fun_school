import 'package:citycloud_school/ui/study_page/controller/my_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';
import 'controller/my_courses_controller.dart';
import 'controller/my_study_plan_controller.dart';
import 'study_page.dart';

abstract class StudyPageState extends State<StudyPage> with TickerProviderStateMixin {
  late TabController pageTabController;
  late MyCoursesController myCoursesController;
  late MyNotesController myNotesController;
  late MyStudyPlanController myStudyPlanController;

  @override
  void initState() {
    pageTabController = TabController(length: 3, vsync: this);
    myCoursesController = MyCoursesController();
    myNotesController = MyNotesController();
    myStudyPlanController = MyStudyPlanController();
    super.initState();
  }

  @override
  void dispose() {
    pageTabController.dispose();
    if (myCoursesController.apiState != ApiState.loading) {
      myCoursesController.dispose();
    }
    if (myNotesController.apiState != ApiState.loading) {
      myNotesController.dispose();
    }
    if (myStudyPlanController.apiState != ApiState.loading) {
      myStudyPlanController.dispose();
    }
    super.dispose();
  }
}
