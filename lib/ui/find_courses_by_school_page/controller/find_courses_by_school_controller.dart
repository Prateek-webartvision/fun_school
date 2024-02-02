import 'package:citycloud_school/models/courses_details/courses.model.dart';
import 'package:citycloud_school/repo/courses_and_details_repo/courses_and_details_repo.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import 'school_selector_controller.dart';

class FindCoursesBySchoolController extends GetxController {
  ApiState apiState = ApiState.loading;
  String? error;

  List<CoursesModel> _coursesList = [];
  List<CoursesModel>? coursesBySearch;

  List<CoursesModel> selectedSubject = [];

  Set<String>? subSchoolSet;
  int subSchoolSelectionIndex = 0;

  late SchoolSelectorController schoolSelectorController;

  FindCoursesBySchoolController() {
    _initLoadDate();
  }

  updateEnrollers(CoursesModel item) {
    item.isCourseEnrolled = !item.isCourseEnrolled;
    update();
  }

  changeCourseSelection(CoursesModel selectedSubject) {
    if (this.selectedSubject.contains(selectedSubject)) {
      this.selectedSubject.remove(selectedSubject);
    } else {
      this.selectedSubject.add(selectedSubject);
    }
    update();
  }

  reload() {
    _initLoadDate();
  }

  _initLoadDate() async {
    await _getCourses();

    schoolSelectorController = SchoolSelectorController(
        schoolSelectedIndex: 0, coursesList: _coursesList);

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: '',
      sortByQuery: '',
    );
    _setSubSchool();
  }

  onSchoolChange() {
    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: '',
      sortByQuery: '',
    );
    _setSubSchool();

    update();
  }

  _setSubSchool() {
    subSchoolSelectionIndex = 0;
    subSchoolSet =
        coursesBySearch!.map((e) => e.courseSchoolSubCategory!).toSet();

    final subSchool = subSchoolSet!.toList();

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: subSchool[subSchoolSelectionIndex],
      sortByQuery: '',
    );
    update();
  }

  changeSubSchoolSet(int index) {
    subSchoolSelectionIndex = index;
    final subSchool = subSchoolSet!.toList();

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: subSchool[subSchoolSelectionIndex],
      sortByQuery: '',
    );
    update();
  }

  searchSort(String value) {
    final subSchool = subSchoolSet!.toList();

    coursesBySearch = _allSort(
      data: _coursesList,
      sortBySchool: schoolSelectorController.selectionKey,
      sortByTag: subSchool[subSchoolSelectionIndex],
      sortByQuery: value,
    );

    update();
  }

  List<CoursesModel> _allSort(
      {required List<CoursesModel> data,
      required String sortBySchool,
      required String sortByTag,
      required String sortByQuery}) {
    List<CoursesModel> filteredData = data;

    // school level filter
    if (sortBySchool.isNotEmpty) {
      List<CoursesModel> tempList = filteredData
          .where((element) => element.courseSchool == sortBySchool)
          .toList();
      filteredData = tempList;
    }

    //sort by tag
    if (sortByTag.isNotEmpty) {
      List<CoursesModel> tempList = filteredData
          .where((element) => element.courseSchoolSubCategory == sortByTag)
          .toList();
      filteredData = tempList;
    }

    // search filter
    if (sortByQuery.isNotEmpty) {
      List<CoursesModel> tempList = filteredData
          .where((element) => element.courseName!
              .toLowerCase()
              .contains(sortByQuery.toLowerCase().trim()))
          .toList();
      filteredData = tempList;
    }

    return filteredData;
  }

  // loading course data
  _getCourses() async {
    apiState = ApiState.loading;
    update();
    await reloadWithLoading();
  }

  reloadWithLoading() async {
    await CoursesAndDetailsRepository.getCoursesAndDetails.then((v) {
      apiState = ApiState.success;

      _coursesList = v;
    }).onError((error, stackTrace) {
      apiState = ApiState.error;
      this.error = error.toString();
    });
    update();
  }

  @override
  dispose() {
    schoolSelectorController.dispose();
    super.dispose();
  }
}
