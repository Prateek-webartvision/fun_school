import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

import '../../models/exams/exam_study_plan_models/exam_study_plan_model.dart';

class ExamStudyPlanRepository {
  static final _api = AppApi();

  static Future<List<ExamStudyPlanModel>> getStudyPlans() async {
    return await _api.getApi(AppUrls.examStudyPlans).then((value) {
      List<ExamStudyPlanModel> temp = [];
      for (var element in value) {
        final plan = ExamStudyPlanModel.fromJson(element);
        temp.add(plan);
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
