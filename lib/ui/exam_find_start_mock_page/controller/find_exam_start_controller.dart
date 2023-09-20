import 'package:citycloud_school/models/exams/exams_models/all_exam_model.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/exams/exams_repo.dart';

class FindExamStartController extends GetxController {
  final String examId;
  late ApiState state;
  String? error;
  AllExamModel2? allExams;

  FindExamStartController({required this.examId}) {
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
    await ExamsRepository.getExamByExamId(examId: examId).then((value) {
      state = ApiState.success;
      allExams = value.first;
    }).onError((error, stackTrace) {
      state = ApiState.error;
      this.error = error.toString();
    });
    update();
  }
}
