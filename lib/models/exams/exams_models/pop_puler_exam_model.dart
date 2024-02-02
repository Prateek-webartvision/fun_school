import 'all_exam_model.dart';

class PopPulerExamsModel {
  int? examCategoryId;
  String? examCategoryName;
  String? recommendation;
  int? dateAdded;
  List<AllExamModel>? allExams;

  PopPulerExamsModel.fromJson(Map<String, dynamic> json) {
    examCategoryId = int.tryParse(json['exam_category_id']);
    examCategoryName = json['exam_category_name'];
    recommendation = json['recommendation'];
    dateAdded = json['date_added'];
    if (json['all_exams'] != null) {
      List<AllExamModel> allExams = [];
      for (var element in json['all_exams']) {
        final exam = AllExamModel.fromJson(element);
        allExams.add(exam);
      }
      this.allExams = allExams;
    }
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
