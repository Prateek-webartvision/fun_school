class StudyPlanModel {
  int? studyPlanId;
  String? userId;
  String? title;
  String? description;
  String? datePosted;

  StudyPlanModel.fromJson(Map<String, dynamic> json) {
    studyPlanId = int.parse(json['study_plan_id'].toString());
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    datePosted = json['date_posted'];
  }
}
