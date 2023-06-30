import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import '../../network/app_api.dart';

class EnrollCoursesRepository {
  static final _api = AppApi();

  static enrollCourse(int? courseId) async {
    var data = <String, dynamic>{};

    data['user_id'] = AppStorage.user.currentUser()!.userid.toString();
    data['course_id'] = courseId.toString();

    await _api.postApi(AppUrls.enrollCourse, params: data).then((value) {
      // if(value['code'] != )
      // print(value);
      AppUtils.showSnack(value['message']);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }
}
