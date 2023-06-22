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

  @override
  void dispose() {
    pageTabController.dispose();
    super.dispose();
  }
}
