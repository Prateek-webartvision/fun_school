import 'package:fun_school/utils/app_utils.dart';

import 'subject.model.dart';

class CoursesModel {
  int? courseId;
  String? courseName;
  String? courseDescription;
  String? courseCoverImage;
  String? courseSchool;
  String? courseSchoolSubCategory;
  String? courseCareer;
  String? courseInterest;
  String? courseProficiency;
  List<CoursesSubject>? courseSubjects;
  List<CoursesEnrollment>? courseEnrollment;
  String? status;
  String? dateAdded;
  bool isCourseEnrolled = false;

  CoursesModel({
    this.courseId,
    this.courseName,
    this.courseDescription,
    this.courseCoverImage,
    this.courseSchool,
    this.courseSchoolSubCategory,
    this.courseCareer,
    this.courseInterest,
    this.courseProficiency,
    this.courseSubjects,
    this.status,
    this.dateAdded,
  });

  CoursesModel.fromJson(Map<String, dynamic> json) {
    courseId = int.parse(json['course_id'].toString());
    courseName = json['course_name'];
    courseDescription = json['course_description'];
    courseCoverImage = json['course_cover_image'];
    courseSchool = json['course_school'];
    courseSchoolSubCategory = json['course_school_sub_category'];
    courseCareer = json['course_career'];
    courseInterest = json['course_interest'];
    courseProficiency = json['course_proficiency'];
    if (json['course_subjects'] != null) {
      List<CoursesSubject> courseSubjects = [];
      for (var element in json['course_subjects']) {
        courseSubjects.add(CoursesSubject.fromJson(element));
      }
      this.courseSubjects = courseSubjects;
    }

    if (json['course_enrollment'] != null) {
      List<CoursesEnrollment> courseEnrollment = [];
      for (var element in json['course_enrollment']) {
        courseEnrollment.add(CoursesEnrollment.fromJson(element));
      }
      this.courseEnrollment = courseEnrollment;
      isCourseEnrolled =
          AppUtils.isCourseEnrolledByMe(enrolls: this.courseEnrollment!);
    }

    status = json['status'];
    dateAdded = json['date_added'];
  }
}

class CoursesEnrollment {
  int? courseEnrollmentId;
  String? userId;
  String? username;
  String? progress;
  String? dateAdded;

  CoursesEnrollment.fromJson(Map<String, dynamic> json) {
    courseEnrollmentId = int.parse(json['course_enrollment_id'].toString());
    userId = json['user_id'];
    username = json['username'];
    progress = json['progress'];
    dateAdded = json['date_added'];
  }
}
