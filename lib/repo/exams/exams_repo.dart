import 'package:citycloud_school/models/exams/exams_models/all_exam_model.dart';
import 'package:citycloud_school/models/exams/exams_models/populer_exam_model.dart';
import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:flutter/foundation.dart';

class ExamsRepository {
  static final _api = AppApi();

  static Future<List<PopulerExamsModel>> getExams() async {
    return await _api.getApi(AppUrls.getExams).then((value) {
      // print(value);
      List<PopulerExamsModel> exams = [];
      for (var element in value) {
        final populerExam = PopulerExamsModel.fromJson(element);
        exams.add(populerExam);
      }
      return exams;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // get exam by exam id
  static Future<List<AllExamModel2>> getExamByExamId({required String examId}) async {
    Map<String, String> perams = {};
    perams['exam_id'] = examId;
    perams["user_id"] = AppStorage.user.currentUser()?.userid.toString() ?? "";

    return await _api.getApi(AppUrls.getExamsByExamId, params: perams).then((value) {
      List<AllExamModel2> exams = [];
      for (var element in value) {
        final exam = AllExamModel2.fromJson(element);
        exams.add(exam);
      }
      return exams;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  static saveMultiChoiceExamScore({required String examId, required String score}) async {
    // final url = AppUrls.saveMultiChoiceExamScore;
    Map<String, String> perams = {};
    perams["user_id"] = AppStorage.user.currentUser()!.userid.toString();
    perams["exam_id"] = examId;
    perams["score"] = score;

    await _api.postApi(AppUrls.saveMultiChoiceExamScore, params: perams).then(
      (value) {
        debugPrint(value.toString());
      },
    ).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    // print(perams);
  }
}
