class TheoryQuestionModel {
  int? questionId;
  String? examId;
  String? questionNo;
  String? points;
  String? question;
  String? answer;
  int? date;
  bool? ansSubmited = false;

  TheoryQuestionModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    examId = json['exam_id'];
    questionNo = json['question_no'];
    points = json['points'];
    question = json['question'];
    answer = json['answer'];
    date = json['date'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};

    json['question_id'] = questionId;
    json['exam_id'] = examId;
    json['question_no'] = questionNo;
    json['points'] = points;
    json['question'] = question;
    json['answer'] = answer;
    json['date'] = date;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
