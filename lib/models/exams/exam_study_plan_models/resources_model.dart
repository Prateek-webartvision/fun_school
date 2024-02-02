class ResourcesModel {
  int? resourceId;
  String? studyPlanId;
  String? title;
  String? link;
  int? dateAdded;

  ResourcesModel.fromJson(Map<String, dynamic> json) {
    resourceId = int.parse(json['resource_id']);
    studyPlanId = json['study_plan_id'];
    title = json['title'];
    link = json['link'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['resource_id'] = resourceId;
    json['study_plan_id'] = studyPlanId;
    json['title'] = title;
    json['link'] = link;
    json['date_added'] = dateAdded;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}
