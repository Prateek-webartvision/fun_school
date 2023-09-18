class PopulerExamsModel {
  int? examCategoryId;
  String? examCategoryName;
  String? recommendation;
  String? dateAdded;

  PopulerExamsModel.fromJson(Map<String, dynamic> json) {
    examCategoryId = json['exam_category_id'];
    examCategoryName = json['exam_category_name'];
    recommendation = json['recommendation'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['exam_category_id'] = examCategoryId;
    json['exam_category_name'] = examCategoryName;
    json['recommendation'] = recommendation;
    json['date_added'] = dateAdded;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
