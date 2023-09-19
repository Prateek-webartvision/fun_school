import 'package:flutter/material.dart';

import 'controller/find_exam_crontroller.dart';
import 'exam_preparation_page.dart';

abstract class ExamPreparationPageState extends State<ExamPreparationPage> with TickerProviderStateMixin {
  late TabController tabController;
  late FindExamCrontroller findExamCrontroller;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    findExamCrontroller = FindExamCrontroller();

    super.initState();
  }
}
