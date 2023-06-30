import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import '../../ui/study_page/model/study_plan_model.dart';

class StudyPlanRepository {
  static final _api = AppApi();

  static buyStudyPlan({required String courseTitle, required String studyPlan}) async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userid.toString();
    data["course"] = courseTitle;
    data["plan"] = studyPlan;

    await _api.postApi(AppUrls.addStudyPlanByContent, params: data).then((value) {
      // print("$value");
      // success
      AppUtils.showSnack(value["message"]);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }

  // fatch my study play
  static Future<List<StudyPlanModel>> getStudyPlans() async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userid.toString();

    return await _api.getApi(AppUrls.getStudyPlans, params: data).then((value) {
      var temp = <StudyPlanModel>[];
      if (value != null) {
        for (var element in value) {
          final plan = StudyPlanModel.fromJson(element);
          temp.add(plan);
        }
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  static Future addStudyPlan({
    required String title,
    required String description,
  }) async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userid.toString();
    data["title"] = title;
    data["description"] = description;

    return await _api.postApi(AppUrls.addStudyPlan, params: data).then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }
}
