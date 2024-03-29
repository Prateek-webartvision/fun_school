import 'package:fun_school/models/exams/exams_models/multi_choice_quetion_model.dart';
import 'package:fun_school/models/exams/exams_models/scrore_model.dart';
import 'package:fun_school/models/exams/exams_models/theory_question_model.dart';

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
    // print(json['exam_id']);
    examId = int.tryParse(json['exam_id'].toString());
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
  int? multiChoiceQuestionsCount;
  int? theoryQuestionsCount;

  AllExamModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    multiChoiceQuestionsCount = int.parse(json['multichoice_questions_count']);
    theoryQuestionsCount = int.tryParse(json['theory_questions_count']);
  }

  @override
  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = super.toJson;

    json['multichoice_questions_count'] = multiChoiceQuestionsCount;
    json['theory_questions_count'] = theoryQuestionsCount;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}

class AllExamModel2 extends _ExamModel {
  String? durationMultiChoice;
  String? durationTheory;
  ScoreModel? multiChoiceScore;
  ScoreModel? theoryScore;
  List<TheoryQuestionModel>? theoryQuestions;
  List<MultiChoiceQuestion>? multiChoiceQuestions;

  AllExamModel2.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    durationMultiChoice = json['duration_multichoice'];
    durationTheory = json['duration_theory'];
    //Scrore
    if (json['multichoice_score'] != null &&
        json['multichoice_score'].isNotEmpty) {
      multiChoiceScore = ScoreModel.fromJson(json['multichoice_score']);
      // multichoiceScore!.grade = "b";
      // print(multichoiceScore?.grade.toString());
    }
    if (json['theory_score'] != null && json['theory_score'].isNotEmpty) {
      theoryScore = ScoreModel.fromJson(json['theory_score']);
    }
    //
    if (json['multichoice_questions'] != null) {
      List<MultiChoiceQuestion> mcqs = [];
      for (var element in json['multichoice_questions']) {
        final mcq = MultiChoiceQuestion.fromJson(element);
        mcqs.add(mcq);
      }
      multiChoiceQuestions = mcqs;
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
    json['duration_multichoice'] = durationMultiChoice;
    json['duration_theory'] = durationTheory;
    return json;
  }

  @override
  toString() {
    return toJson.toString();
  }
}
