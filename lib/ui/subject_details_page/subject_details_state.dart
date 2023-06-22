import 'package:citycloud_school/ui/subject_details_page/controller/subject_details_page_controller.dart';
import 'package:flutter/material.dart';

import 'subject_details_view.dart';

abstract class SubjectDetailsState extends State<SubjectDetailsView> with TickerProviderStateMixin {
  late SubjectDetailsPageController subjectDetailsPageController;
  late TabController pageTabController;

  @override
  void initState() {
    subjectDetailsPageController = SubjectDetailsPageController(subjects: widget.courseData!.courseSubjects!);
    // print(subjectDetailsPageController.subjects.length);
    pageTabController = TabController(length: subjectDetailsPageController.subjects.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    subjectDetailsPageController.dispose();
    pageTabController.dispose();
    super.dispose();
  }
}
