import 'package:citycloud_school/models/exams/exams_models/multi_choice_quetion_model.dart';
import 'package:citycloud_school/models/exams/exams_models/theory_question_model.dart';

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
  int? multichoiceQuestionsCount;
  int? theoryQuestionsCount;
  // List<MultiChoiceQuestion>? multichoiceQuestions;
  // List<TheoryQuestion>? theory_questions;

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
    multichoiceQuestionsCount = json['multichoice_questions_count'];
    theoryQuestionsCount = json['theory_questions_count'];
    // if (json["multichoice_questions"] != null) {
    //   List<MultiChoiceQuestion> questions = [];
    //   for (var element in json["multichoice_questions"]) {
    //     final que = MultiChoiceQuestion.fromJson(element);
    //     questions.add(que);
    //   }
    //   multichoiceQuestions = questions;
    // }
    // if (json["theory_questions"] != null) {
    //   List<TheoryQuestion> questions = [];
    //   for (var element in json["theory_questions"]) {
    //     final que = TheoryQuestion.fromJson(element);
    //     questions.add(que);
    //   }
    //   theory_questions = questions;
    // }
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
    json['multichoice_questions_count'] = multichoiceQuestionsCount;
    json['theory_questions_count'] = theoryQuestionsCount;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}
