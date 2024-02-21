import 'package:fun_school/models/exams/exams_models/all_exam_model.dart';
import 'package:fun_school/models/exams/exams_models/pop_puler_exam_model.dart';
import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';
import 'package:flutter/foundation.dart';

class ExamsRepository {
  static final _api = AppApi();

  //* get all exams
  static Future<List<PopPulerExamsModel>> getExams() async {
    final res = await _api.getApi(AppUrls.getExams);
    List<PopPulerExamsModel> exams = [];
    for (var element in res) {
      final popPulerExam = PopPulerExamsModel.fromJson(element);
      exams.add(popPulerExam);
    }
    return exams;
  }

  //* get exam by exam id
  static Future<List<AllExamModel2>> getExamByExamId({
    required String examId,
  }) async {
    Map<String, String> params = {};
    params['exam_id'] = examId;
    params["user_id"] = AppStorage.user.currentUser()?.userId.toString() ?? "";

    // log(params.toString());
    //TODO error

    final res = await _api.getApi(AppUrls.getExamsByExamId, params: params);

    List<AllExamModel2> exams = [];
    if (res != null) {
      for (var element in res) {
        final exam = AllExamModel2.fromJson(element);
        exams.add(exam);
      }
    }
    return exams;
  }

  static saveMultiChoiceExamScore(
      {required String examId, required String score}) async {
    // final url = AppUrls.saveMultiChoiceExamScore;
    Map<String, String> params = {};
    params["user_id"] = AppStorage.user.currentUser()!.userId.toString();
    params["exam_id"] = examId;
    params["score"] = score;

    await _api.postApi(AppUrls.saveMultiChoiceExamScore, params: params).then(
      (value) {
        debugPrint(value.toString());
      },
    ).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  static submitTheoryExam({
    required String examId,
    required,
    required String questionId,
    required String answer,
  }) async {
    Map<String, String> params = {};
    params["user_id"] = AppStorage.user.currentUser()!.userId.toString();
    params["exam_id"] = examId;
    params["question_type"] = "theory";
    params["question_id"] = questionId;
    params["answer"] = answer;

    return await _api
        .postApi(AppUrls.submitTheoryExam, params: params)
        .then((value) {
      // print(value);
      if (value['message'] != "Exam answer added successfully ") {
        throw value['message'];
      } else {
        return true;
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
