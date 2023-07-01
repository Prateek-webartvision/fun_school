class QuizModel {
  int? quizId;
  String? subjectId;
  String? title;
  List? quizData;

  QuizModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    //  = json['type'];
    subjectId = json['subject_id'];
    title = json['title'];
    // quizId = json['quiz_data'];
  }
}
