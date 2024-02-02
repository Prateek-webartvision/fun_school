import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

import '../../models/courses_details/courses.model.dart';

class CoursesAndDetailsRepository {
  static final _api = AppApi();

  static Future<List<CoursesModel>> get getCoursesAndDetails async {
    final res = await _api.getApi(AppUrls.coursesAndDetailsUrl);
    List<CoursesModel> temp = [];
    if (res != null) {
      for (var element in res) {
        final course = CoursesModel.fromJson(element);
        temp.add(course);
      }
    }
    return temp;
  }
}
