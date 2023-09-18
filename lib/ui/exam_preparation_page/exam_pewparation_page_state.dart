import 'package:citycloud_school/models/exams/exams_models/populer_exam_model.dart';
import 'package:citycloud_school/repo/exams/exams_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

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

class FindExamCrontroller extends GetxController {
  late ApiState state;
  String? error;
  List<PopulerExamsModel>? examsData;

  FindExamCrontroller() {
    initLoadData();
  }

  reload() async {
    await _loadData();
  }

  initLoadData() async {
    state = ApiState.loading;
    update();
    await _loadData();
  }

  _loadData() async {
    await ExamsRepository.getExams().then((value) {
      examsData = value;
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
  }
}
