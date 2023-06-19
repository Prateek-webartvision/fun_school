import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/network/exception/k_exceptions.dart';
import 'package:citycloud_school/repo/courses_and_details_repo/courses_and_details_repo.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class FindCoursesBySchoolController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;
  List<CoursesModel>? coursesList;

  getCourses() async {
    apiState = ApiState.loading;
    update();
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      List<CoursesModel> _coursesList = [];
      for (var element in v) {
        _coursesList.add(CoursesModel.fromJson(element));
      }
      coursesList = _coursesList;
      error = null;
      update();
    }).onError((error, stackTrace) {
      apiState = ApiState.error;
      if (error is KInternetException) {
        AppUtils.showSnack(error.message.toString());
        this.error = error.message.toString();
      } else {
        AppUtils.showSnack(error.toString());
        this.error = error.toString();
      }
      update();
    });
  }
}
