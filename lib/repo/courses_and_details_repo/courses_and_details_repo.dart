import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

class CoursesAndDetailsRepository {
  static final _api = AppApi();

  static Future<dynamic> getCoursesAndDetails() async {
    return await _api.getApi(AppUrls.coursesAndDetailsUrl).then((value) {
      // print("$value");
      return value;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
