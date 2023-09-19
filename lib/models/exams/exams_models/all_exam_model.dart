class AllExamModel {
  int? examId;
  String? examName;
  String? examYear;
  String? examCategory;
  String? examSubCategory;
  String? examSubCategoryName;
  String? examEdition;
  String? examCourseId;
  String? examCourseName;
  int? dateAdded;

  AllExamModel.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    examName = json['exam_name'];
    examYear = json['exam_year'];
    examCategory = json['exam_category'];
    examSubCategory = json['exam_sub_category'];
    examSubCategoryName = json['exam_sub_category_name'];
    examEdition = json['exam_edition'];
    examCourseId = json['exam_course_id'];
    examCourseName = json['exam_course_name'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['exam_id'] = examId;
    json['exam_name'] = examName;
    json['exam_year'] = examYear;
    json['exam_category'] = examCategory;
    json['exam_sub_category'] = examSubCategory;
    json['exam_sub_category_name'] = examSubCategoryName;
    json['exam_edition'] = examEdition;
    json['exam_course_id'] = examCourseId;
    json['exam_course_name'] = examCourseName;
    json['date_added'] = dateAdded;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}
