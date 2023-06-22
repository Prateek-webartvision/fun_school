import 'subject.model.dart';

class CoursesModel {
  int? courseId;
  String? courseName;
  String? courseDescription;
  String? courseCoverImage;
  String? courseSchool;
  String? courseCareer;
  String? courseInterest;
  String? courseProficiency;
  List<CoursesSubject>? courseSubjects;
  // String? courseEnrollment;
  String? status;
  String? dateAdded;

  CoursesModel({
    this.courseId,
    this.courseName,
    this.courseDescription,
    this.courseCoverImage,
    this.courseSchool,
    this.courseCareer,
    this.courseInterest,
    this.courseProficiency,
    this.courseSubjects,
    this.status,
    this.dateAdded,
  });

  CoursesModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    // courseDescription = json['course_description'];
    // courseCoverImage = json['course_cover_image'];
    courseSchool = json['course_school'];
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
    // status = json['status'];
    // dateAdded = json['date_added'];
  }
}
