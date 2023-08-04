import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/flashcard.model.dart';
import '../../../network/exception/k_exceptions.dart';
import '../../../repo/courses_and_details_repo/courses_and_details_repo.dart';
import '../../../repo/study_plan_repo/study_plan_repo.dart';
import '../../../uitls/app_utils.dart';
import '../model/folder_model.dart';

class MyCoursesController extends GetxController {
  List<CoursesModel>? _allCourses;

  List<CoursesModel>? myCourses;
  List<AppFolderModel>? myFolders;
  ApiState apiState = ApiState.loading;
  String? error;

  bool isSelectMode = false;
  List<String> selectedCourseIds = [];

  MyCoursesController() {
    _initDate();
  }

  _initDate() async {
    await _loadFolders();
    await _loadAllCourses();
    _sortCoursesForUser();
  }

  //create new folder
  createFolder(String fName) {
    AppUtils.showloadingOverlay(() async {
      await StudyPlanRepository.createNewFolder(fName).then((value) {
        _loadFolders();
        AppUtils.showSnack(value);
      }).onError((error, stackTrace) {
        AppUtils.showSnack(error.toString());
      });
    });
  }

  // enable selection mode
  enableSelectionMode(String courseID) {
    if (isSelectMode == false) {
      isSelectMode = !isSelectMode;
      selectedCourseIds.add(courseID);
    }
    update();
    // print(selectedCourseIds);
  }

  addCoursesAndRemove(String courseID) {
    if (selectedCourseIds.contains(courseID)) {
      selectedCourseIds.remove(courseID);
    } else {
      selectedCourseIds.add(courseID);
    }
    if (selectedCourseIds.isEmpty) {
      isSelectMode = false;
    }
    update();
  }

  _sortCoursesForUser() {
    List<CoursesModel> temp = [];
    // print(AppStorage.user.currentUser()!.userid);

    if (_allCourses != null) {
      for (var courses in _allCourses!) {
        if (courses.courseEnrollment != null) {
          for (var enroll in courses.courseEnrollment!) {
            // checking current user is enrolled or not
            if (int.parse(enroll.userId!) == AppStorage.user.currentUser()!.userid) {
              temp.add(courses);
            }
          }
        }
      }
    }
    // print(temp);

    myCourses = temp;
    update();
  }

// get my enrollment
  CoursesEnrollment getMyEnrollment(int index) {
    final cs = myCourses![index].courseEnrollment!;
    late CoursesEnrollment myRnroll;
    for (var element in cs) {
      if (int.parse(element.userId!) == AppStorage.user.currentUser()!.userid) {
        myRnroll = element;
      }
    }

    return myRnroll;
  }

  // get my courses
  List<FlashCardModel> getCourseFlashCard({required int index}) {
    // print("object $index");
    List<FlashCardModel> flashcards = [];
    if (myCourses != null || myCourses!.isNotEmpty) {
      for (var element in myCourses![index].courseSubjects!) {
        if (element.flashCard!.isNotEmpty) {
          flashcards.addAll(element.flashCard!);
        }
      }
    }
    return flashcards;
  }

  _loadAllCourses() async {
    apiState = ApiState.loading;
    await CoursesAndDetailsRepository.getCoursesAndDetails().then((v) {
      // print(v);
      apiState = ApiState.success;
      List<CoursesModel> data = [];
      for (var element in v) {
        data.add(CoursesModel.fromJson(element));
      }
      _allCourses = data;
    }).onError((error, stackTrace) {
      apiState = ApiState.error;
      if (error is KInternetException) {
        AppUtils.showSnack(error.message.toString());
        this.error = error.message.toString();
      }
      if (error is FlutterError) {
        /// this error comw due to call api after disposing controller
        AppUtils.showSnack("gotcha");
      } else {
        AppUtils.showSnack(error.toString());
        this.error = error.toString();
      }
    });
    update();
  }

  _loadFolders() async {
    await StudyPlanRepository.getCourseFolders().then((value) {
      myFolders = value;
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
    update();
  }
}
