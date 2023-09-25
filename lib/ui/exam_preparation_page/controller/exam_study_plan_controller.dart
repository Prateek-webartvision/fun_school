import 'package:citycloud_school/repo/exams/exam_study_plan_repo.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exam_study_plan_models/exam_study_plan_model.dart';

class ExamStudyPlanController extends GetxController {
  late ApiState state;
  String? error;
  List<ExamStudyPlanModel>? studyPlans;

  ExamStudyPlanController() {
    initLoad();
  }

  initLoad() async {
    state = ApiState.loading;
    update();
    await _loadData();
  }

  reload() async {
    await _loadData();
  }

  _loadData() async {
    await ExamStudyPlanRepository.getStudyPlans().then((value) {
      studyPlans = value;
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
  }
}
