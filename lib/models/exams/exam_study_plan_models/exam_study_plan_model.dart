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

  ExamStudyPlanModel(
      {this.examStudyPlanId, this.examName, this.dateOfExam, this.examCourses, this.studyHours, this.progressHours, this.progressPercentage, this.studyPeriods, this.reminderSettings, this.dateAdded});

  ExamStudyPlanModel.fromJson(Map<String, dynamic> json) {
    examStudyPlanId = json['exam_study_plan_id'];
    examName = json['exam_name'];
    dateOfExam = json['date_of_exam'];
    examCourses = json['exam_courses'];
    studyHours = json['study_hours'];
    progressHours = json['progress_hours'];
    progressPercentage = json['progress_percentage'];
    studyPeriods = json['study_periods'];
    reminderSettings = json['reminder_settings'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> get toJson {
    final Map<String, dynamic> data = {};
    data['exam_study_plan_id'] = examStudyPlanId;
    data['exam_name'] = examName;
    data['date_of_exam'] = dateOfExam;
    data['exam_courses'] = examCourses;
    data['study_hours'] = studyHours;
    data['progress_hours'] = progressHours;
    data['progress_percentage'] = progressPercentage;
    data['study_periods'] = studyPeriods;
    data['reminder_settings'] = reminderSettings;
    data['date_added'] = dateAdded;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
