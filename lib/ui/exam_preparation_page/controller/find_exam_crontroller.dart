import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exams_models/all_exam_model.dart';
import '../../../models/exams/exams_models/populer_exam_model.dart';
import '../../../repo/exams/exams_repo.dart';

class FindExamCrontroller extends GetxController {
  late ApiState state;
  String? error;
  List<PopulerExamsModel>? populerExams;
  List<PopulerExamsModel>? recommendedExams;
  List<List<AllExamModel>>? sortedAllExam;

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

  // get exams by sub get
  List<List<AllExamModel>> getExamsBySubCategories({required String subCat, required List<List<AllExamModel>> allExam}) {
    final cates = allExam.where((element) => element.first.examSubCategoryName == subCat).toList();

    return cates;
  }

  groupAllExamByName({required List<String?> catBtnSet, required List<AllExamModel> allExams}) {
    Set exams = allExams.map((e) => e.examCourseName).toSet();

    List<List<AllExamModel>> sortExam = [];

    for (var cat in catBtnSet) {
      final data = allExams.where((e) => e.examSubCategoryName == cat).toList();

      for (var ex in exams) {
        final st = data.where((element) => element.examCourseName == ex).toList();
        if (st.isNotEmpty) {
          sortExam.add(st);
        }
      }
    }
    sortedAllExam = sortExam;
  }

  _loadData() async {
    await ExamsRepository.getExams().then((value) {
      // examsData = value;
      _filerPopulerAndRecomdedExams(value);
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
  }

  _filerPopulerAndRecomdedExams(List<PopulerExamsModel>? data) {
    // Set recommendation = data!.map((e) => e.recommendation).toSet();
    List<String> recommendation = ["recommended", "popular"];
    List<PopulerExamsModel> populerExams = [];
    List<PopulerExamsModel> recommendedExam = [];

    for (var element in data!) {
      if (element.recommendation == recommendation[0]) {
        recommendedExam.add(element);
      }
      if (element.recommendation == recommendation[1]) {
        populerExams.add(element);
      }
    }

    recommendedExams = recommendedExam;
    this.populerExams = populerExams;
  }
}
