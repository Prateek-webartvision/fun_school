import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';
import 'package:fun_school/utils/app_utils.dart';

import '../../network/app_api.dart';

class EnrollCoursesRepository {
  static final _api = AppApi();

  static Future enrollCourse(int? courseId) async {
    var data = <String, dynamic>{};

    data['user_id'] = AppStorage.user.currentUser()!.userId.toString();
    data['course_id'] = courseId.toString();

    return await _api.postApi(AppUrls.enrollCourse, params: data).then((value) {
      // print(value);
      AppUtils.showSnack(value['message']);
      return value["code"];
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }
}
