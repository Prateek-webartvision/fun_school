import 'package:citycloud_school/models/exams/exams_models/populer_exam_model.dart';
import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

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
}
