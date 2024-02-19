import 'dart:convert';

import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';
import 'package:fun_school/utils/app_utils.dart';

import '../../ui/study_page/model/folder_model.dart';
import '../../ui/study_page/model/study_plan_model.dart';

class StudyPlanRepository {
  static final _api = AppApi();

  static buyStudyPlan(
      {required List<String> courseTitle, required String studyPlan}) async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userId.toString();
    data["course"] = jsonEncode(courseTitle);
    data["plan"] = studyPlan;

    // print(data);
    //todo
    await _api
        .postApi(AppUrls.addStudyPlanByContent, params: data)
        .then((value) {
      // print("$value");
      // success
      AppUtils.showSnack(value["message"]);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }

  // fetch my study play
  static Future<List<StudyPlanModel>> getStudyPlans() async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userId.toString();

    return await _api.getApi(AppUrls.getStudyPlans, params: data).then((value) {
      var temp = <StudyPlanModel>[];
      if (value != null) {
        for (var element in value) {
          final plan = StudyPlanModel.fromJson(element);
          temp.add(plan);
        }
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  static Future addStudyPlan({
    required String title,
    required String description,
  }) async {
    Map<String, String> data = {};
    data["user_id"] = AppStorage.user.currentUser()!.userId.toString();
    data["title"] = title;
    data["description"] = description;

    return await _api.postApi(AppUrls.addStudyPlan, params: data).then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  // create new folder
  static Future createNewFolder(String folderName) async {
    Map<String, String> data = {
      "user_id": AppStorage.user.currentUser()!.userId!.toString(),
      "folder_title": folderName,
    };
    return await _api.postApi(AppUrls.createFolder, params: data).then((value) {
      if (value['code'] == 200) {
        return value['message'];
      } else {
        throw value['message'];
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  //* fetch all folders
  static Future<List<AppFolderModel>> get getCourseFolders async {
    Map<String, String> params = {};
    final user = AppStorage.user;
    if (user.current != null) {
      params['user_id'] = user.current!.userId?.toString() ?? "";
    }

    final res = await _api.postApi(AppUrls.myCourseFolders, params: params);
    List<AppFolderModel> myList = [];
    if (res != null) {
      for (var element in res) {
        final dir = AppFolderModel.fromJson(element);
        // if (int.parse(dir.userId!) == user.current?.userId) {
        myList.add(dir);
        // }
      }
    }
    return myList;
  }

  // add to folder api
  static addToFolder(
      {required String folderId,
      required List<String> selectedCourseIds}) async {
    Map<String, String> data = {
      "user_id": AppStorage.user.currentUser()!.userId!.toString(),
      "folder_id": folderId,
      "course_id": jsonEncode(selectedCourseIds),
    };

    await _api.postApi(AppUrls.addToFolders, params: data).then((value) {
      AppUtils.showSnack(value['message']);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
    // print(data);
  }

  //* get folder courses by user
  static Future<List<FolderCourseModel>> get getFolderCoursesByUser async {
    Map<String, String> params = {};
    final user = AppStorage.user;
    if (user.current != null) {
      params['user_id'] = user.current!.userId?.toString() ?? "";
    }

    final res =
        await _api.postApi(AppUrls.getCourseInUserFolder, params: params);
    List<FolderCourseModel> temp = [];
    if (res != null) {
      for (var element in res) {
        final course = FolderCourseModel.fromJson(element);
        temp.add(course);
      }
    }
    return temp;
  }

  // get my enrolled course with folder
  static Future<List<EnrolledCoursesFolder>?>
      getMyEnrolledCorseAndFolders() async {
    Map<String, String> data = {
      "user_id": AppStorage.user.currentUser()!.userId!.toString()
    };

    return await _api
        .postApi(AppUrls.getMyEnrolledCoursesAndFolder, params: data)
        .then((value) {
      List<EnrolledCoursesFolder> temp = [];
      if (value != null) {
        for (var element in value) {
          final enrol = EnrolledCoursesFolder.fromJson(element);
          temp.add(enrol);
        }
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  // remove course From folder
  static Future removeCourseFromfolder(
      {required String courseId, required String folderId}) async {
    Map<String, String> data = {
      "user_id": AppStorage.user.currentUser()!.userId!.toString(),
      "folder_id": folderId,
      "course_id": courseId,
    };

    return await _api
        .postApi(AppUrls.removeCourseFromFolder, params: data)
        .then((value) {
      if (value['code'] == 200) {
        return value['message'];
      } else {
        throw value['message'];
      }
    }).onError(
      (error, stackTrace) {
        throw error!;
      },
    );
  }
}

class EnrolledCoursesFolder {
  int? courseEnrollmentId;
  String? userId;
  String? username;
  String? courseId;
  String? courseName;
  String? folderId;
  String? progress;
  String? dateAdded;

  EnrolledCoursesFolder.fromJson(Map<String, dynamic> json) {
    courseEnrollmentId = int.parse(json['course_enrollment_id'].toString());
    userId = json['user_id'];
    username = json['username'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    folderId = json['folder_id'];
    progress = json['progress'];
    dateAdded = json['date_added'];
  }
}

class FolderCourseModel {
  int? id;
  String? userId;
  String? folderId;
  String? folderName;
  String? courseId;
  String? courseName;
  String? datePosted;

  FolderCourseModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    userId = json['user_id'];
    folderId = json['folder_id'];
    folderName = json['folder_name'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    datePosted = json['date_posted'];
  }
}
