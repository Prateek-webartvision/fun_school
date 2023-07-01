class MockQuizModel {
  int? quizId;
  String? subjectId;
  String? title;
  String? question;
  List<String>? answersOptions;
  String? correctAnswer;
  String? datePosted;
  String? seletedAmswer;

  MockQuizModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    subjectId = json['subject_id'];
    title = json['title'];
    question = json['question'];
    if (json['answers_options'] != null) {
      List<String> temp = [];
      for (var element in json['answers_options']) {
        temp.add(element);
      }
      answersOptions = temp;
    }
    correctAnswer = json['correct_answer'];
    datePosted = json['date_posted'];
  }

  selectAns(String ans) {
    seletedAmswer = ans;
  }
}
