import 'course_name_model.dart';
import 'resources_model.dart';
import 'time_table_model.dart';

class ExamStudyPlanModel {
  int? examStudyPlanId;
  String? examName;
  int? dateOfExam;
  String? examCourses;
  String? studyHours;
  String? progressHours;
  num? progressPercentage;
  String? studyPeriods;
  String? reminderSettings;
  int? dateAdded;
  List<CoursesName>? examStudyPlanCourses;
  List<TimeTableModel>? examStudyPlanTimetable;
  List<ResourcesModel>? examStudyPlanResources;

  ExamStudyPlanModel({
    this.examStudyPlanId,
    this.examName,
    this.dateOfExam,
    this.examCourses,
    this.studyHours,
    this.progressHours,
    this.progressPercentage,
    this.studyPeriods,
    this.reminderSettings,
    this.dateAdded,
    this.examStudyPlanCourses,
    this.examStudyPlanTimetable,
    this.examStudyPlanResources,
  });

  ExamStudyPlanModel.fromJson(Map<String, dynamic> json) {
    examStudyPlanId = int.tryParse(json['exam_study_plan_id']);
    examName = json['exam_name'];
    dateOfExam = json['date_of_exam'];
    examCourses = json['exam_courses'];
    studyHours = json['study_hours'];
    progressHours = json['progress_hours'];
    progressPercentage = json['progress_percentage'];
    studyPeriods = json['study_periods'];
    reminderSettings = json['reminder_settings'];
    dateAdded = json['date_added'];
    if (json['exam_study_plan_courses'] != null) {
      List<CoursesName> temp = [];
      for (var element in json['exam_study_plan_courses']) {
        final course = CoursesName.fromJson(element);
        temp.add(course);
      }
      examStudyPlanCourses = temp;
    }
    if (json['exam_study_plan_timetable'] != null) {
      List<TimeTableModel> temp = [];
      for (var element in json['exam_study_plan_timetable']) {
        final timeTable = TimeTableModel.fromJson(element);
        temp.add(timeTable);
      }
      examStudyPlanTimetable = temp;
    }
    if (json['exam_study_plan_resources'] != null) {
      List<ResourcesModel> temp = [];
      for (var element in json['exam_study_plan_resources']) {
        final resource = ResourcesModel.fromJson(element);
        temp.add(resource);
      }
      examStudyPlanResources = temp;
    }
  }

  Map<String, dynamic> get toJson {
    final Map<String, dynamic> json = {};
    json['exam_study_plan_id'] = examStudyPlanId;
    json['exam_name'] = examName;
    json['date_of_exam'] = dateOfExam;
    json['exam_courses'] = examCourses;
    json['study_hours'] = studyHours;
    json['progress_hours'] = progressHours;
    json['progress_percentage'] = progressPercentage;
    json['study_periods'] = studyPeriods;
    json['reminder_settings'] = reminderSettings;
    json['date_added'] = dateAdded;
    json['exam_study_plan_timetable'] = examStudyPlanTimetable;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
