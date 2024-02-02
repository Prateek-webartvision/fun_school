import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exams_models/all_exam_model.dart';
import '../../../models/exams/exams_models/pop_puler_exam_model.dart';
import '../../../repo/exams/exams_repo.dart';

class FindExamController extends GetxController {
  late ApiState state;
  String? error;
  List<PopPulerExamsModel>? popPulerExams;
  List<PopPulerExamsModel>? recommendedExams;
  List<List<AllExamModel>>? sortedAllExam;

  FindExamController() {
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

  //* get exams by sub get
  List<List<AllExamModel>> getExamsBySubCategories(
      {required String subCat, required List<List<AllExamModel>> allExam}) {
    final cates = allExam
        .where((element) => element.first.examSubCategoryName == subCat)
        .toList();

    return cates;
  }

  groupAllExamByName({
    required List<String?> catBtnSet,
    required List<AllExamModel> allExams,
  }) {
    Set exams = allExams.map((e) => e.examCourseName).toSet();

    List<List<AllExamModel>> sortExam = [];

    for (var cat in catBtnSet) {
      final data = allExams.where((e) => e.examSubCategoryName == cat).toList();

      for (var ex in exams) {
        final st =
            data.where((element) => element.examCourseName == ex).toList();
        if (st.isNotEmpty) {
          sortExam.add(st);
        }
      }
    }
    sortedAllExam = sortExam;
  }

  _loadData() async {
    try {
      final res = await ExamsRepository.getExams();
      _filerPopPulerAndRecommendedExams(res);
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }

  _filerPopPulerAndRecommendedExams(List<PopPulerExamsModel>? data) {
    List<String> recommendation = ["recommended", "popular"];
    List<PopPulerExamsModel> popPulerExams = [];
    List<PopPulerExamsModel> recommendedExam = [];

    for (var element in data!) {
      if (element.recommendation == recommendation[0]) {
        recommendedExam.add(element);
      }
      if (element.recommendation == recommendation[1]) {
        popPulerExams.add(element);
      }
    }

    recommendedExams = recommendedExam;
    this.popPulerExams = popPulerExams;
  }
}
