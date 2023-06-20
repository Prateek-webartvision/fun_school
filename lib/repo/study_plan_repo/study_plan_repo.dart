import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

class StudyPlanRepository {
  static final _api = AppApi();

  static buyStudyPlan(int subjectId) async {
    Map<String, String> data = {};
    data["user_id"] = subjectId.toString();
    data["subject_id"] = "1";
    data["plan"] = "Study plan";

    await _api.postApi(AppUrls.addStudyPlanUrl, params: data).then((value) {
      print("$value");
      // success
      AppUtils.showSnack(value["message"]);
    }).onError((error, stackTrace) {
      // fail
      print("object $error");
    });
  }
}
