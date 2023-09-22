import 'package:citycloud_school/models/exams/exams_models/multi_choice_quetion_model.dart';
import 'package:citycloud_school/models/exams/exams_models/scrore_model.dart';
import 'package:citycloud_school/models/exams/exams_models/theory_question_model.dart';

abstract class _ExamModel {
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

  _ExamModel.fromJson(Map<String, dynamic> json) {
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

class AllExamModel extends _ExamModel {
  int? multichoiceQuestionsCount;
  int? theoryQuestionsCount;

  AllExamModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    multichoiceQuestionsCount = json['multichoice_questions_count'];
    theoryQuestionsCount = json['theory_questions_count'];
  }

  @override
  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = super.toJson;

    json['multichoice_questions_count'] = multichoiceQuestionsCount;
    json['theory_questions_count'] = theoryQuestionsCount;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}

class AllExamModel2 extends _ExamModel {
  String? durationMultichoice;
  String? durationTheory;
  ScoreModel? latestScore;
  List<TheoryQuestionModel>? theoryQuestions;
  List<MultiChoiceQuestion>? multichoiceQuestions;

  AllExamModel2.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    durationMultichoice = json['duration_multichoice'];
    durationTheory = json['duration_theory'];
    //Scrore
    if (json['latest_score'] != null && json['latest_score'].isNotEmpty) {
      latestScore = ScoreModel.fromJson(json['latest_score']);
      // print(json['latest_score']);
    }
    //
    if (json['multichoice_questions'] != null) {
      List<MultiChoiceQuestion> mcqs = [];
      for (var element in json['multichoice_questions']) {
        final mcq = MultiChoiceQuestion.fromJson(element);
        mcqs.add(mcq);
      }
      multichoiceQuestions = mcqs;
    }
    if (json['theory_questions'] != null) {
      List<TheoryQuestionModel> theoryquestions = [];
      for (var element in json['theory_questions']) {
        final th = TheoryQuestionModel.fromJson(element);
        theoryquestions.add(th);
      }
      theoryQuestions = theoryquestions;
    }
  }

  @override
  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = super.toJson;
    json['duration_multichoice'] = durationMultichoice;
    json['duration_theory'] = durationTheory;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}
