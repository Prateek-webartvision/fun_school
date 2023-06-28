import 'package:citycloud_school/ui/study_page/controller/my_notes_controller.dart';
import 'package:flutter/material.dart';
import 'controller/my_courses_controller.dart';
import 'study_page.dart';

abstract class StudyPageState extends State<StudyPage> with TickerProviderStateMixin {
  late TabController pageTabController;
  late MyCoursesController myCoursesController;
  late MyNotesController myNotesController;

  @override
  void initState() {
    pageTabController = TabController(length: 3, vsync: this);
    myCoursesController = MyCoursesController();
    myNotesController = MyNotesController();
    super.initState();
  }

  @override
  void dispose() {
    pageTabController.dispose();
    if (myCoursesController.myCourses != null) {
      myCoursesController.dispose();
    }
    if (myNotesController.myNotes != null) {
      myNotesController.dispose();
    }
    super.dispose();
  }
}
