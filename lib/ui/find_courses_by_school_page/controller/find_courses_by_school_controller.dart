import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/network/exception/k_exceptions.dart';
import 'package:citycloud_school/repo/courses_and_details_repo/courses_and_details_repo.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import 'school_selector_controller.dart';

class FindCoursesBySchoolController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;
  List<CoursesModel>? _coursesList;
  List<CoursesModel>? coursesBySchool;

  SchoolSelectorController schoolSelectorController = SchoolSelectorController(schoolSeletedIndex: 0);

  FindCoursesBySchoolController() {
    _initLoadDate();
  }

  _initLoadDate() async {
    await _getCourses();
    _sortBySchool(schoolSelectorController.selectionKey);
    schoolSelectorController.addListener(() {
      _sortBySchool(schoolSelectorController.selectionKey);
    });
  }

  // sort by school
  _sortBySchool(String sortby) async {
    List<CoursesModel> _sortData = [];
    if (_coursesList != null) {
      for (var element in _coursesList!) {
        if (element.courseSchool == sortby) {
          _sortData.add(element);
        }
      }
    }
    coursesBySchool = _sortData;
    update();
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    update();
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      apiState = ApiState.success;
      List<CoursesModel> _data = [];
      for (var element in v) {
        _data.add(CoursesModel.fromJson(element));
      }
      _coursesList = _data;
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

  @override
  dispose() {
    schoolSelectorController.dispose();
    super.dispose();
  }
}
