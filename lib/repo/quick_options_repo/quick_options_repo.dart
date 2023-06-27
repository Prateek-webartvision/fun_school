import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import '../../network/app_api.dart';
import '../../network/url/app_urls.dart';

class QuickOptionRepository {
  static final _api = AppApi();

  static addNote({
    required String noteTitle,
    required int subjectId,
    required String contentTitle,
    required String subtitle,
    required String note,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = AppStorage.user.currentUser()!.userid!.toString();
    data['subject_id'] = subjectId.toString();
    data["title"] = contentTitle;
    data["subtitle"] = subtitle;
    data['notes'] = note;

    return await _api.postApi(AppUrls.addSubjectNotes, params: data).then((value) {
      if (value["code"] == 200) {
        return value['message'];
      } else {
        AppUtils.showSnack(value['message']);
      }
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }
}
