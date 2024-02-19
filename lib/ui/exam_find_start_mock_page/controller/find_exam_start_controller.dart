import 'package:fun_school/models/exams/exams_models/all_exam_model.dart';
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
    try {
      final res = await ExamsRepository.getExamByExamId(examId: examId);
      state = ApiState.success;
      if (res.isNotEmpty) {
        allExams = res.first;
      }
    } catch (e) {
      state = ApiState.error;
      error = e.toString();
    }
    update();
  }
}
