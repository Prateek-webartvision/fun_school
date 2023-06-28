import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

class StudyPlanRepository {
  static final _api = AppApi();

  static buyStudyPlan(int subjectId) async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userid.toString();
    data["subject_id"] = subjectId.toString();
    data["plan"] = "Study plan";

    await _api.postApi(AppUrls.addStudyPlanUrl, params: data).then((value) {
      print("$value");
      // success
      AppUtils.showSnack(value["message"]);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }
}
