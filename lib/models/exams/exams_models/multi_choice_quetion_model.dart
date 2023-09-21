class MultiChoiceQuestion {
  int? questionId;
  String? examId;
  String? questionNo;
  String? points;
  String? question;
  List<String>? questionAnswers;
  String? correctAnswer;
  int? date;

  MultiChoiceQuestion.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    examId = json['exam_id'];
    questionNo = json['question_no'];
    points = json['points'];
    question = json['question'];
    if (json['question_answers'] != null) {
      List<String>? temp = [];
      for (var element in json['question_answers']) {
        temp.add(element);
      }
      questionAnswers = temp;
    }
    correctAnswer = json['correct_answer'];
    date = json['date'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['question_id'] = questionId;
    json['exam_id'] = examId;
    json['question_no'] = questionNo;
    json['points'] = points;
    json['question'] = question;
    json['question_answers'] = questionAnswers;
    json['correct_answer'] = correctAnswer;
    json['date'] = date;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
