class MultiChoiceQuestion {
  int? question_id;
  String? exam_id;
  String? question_no;
  String? points;
  String? question;
  String? answer_1;
  String? answer_2;
  String? answer_3;
  String? answer_4;
  String? answer_5;
  String? correct_answer;
  int? date;

  MultiChoiceQuestion.fromJson(Map<String, dynamic> json) {
    question_id = json['question_id'];
    exam_id = json['exam_id'];
    question_no = json['question_no'];
    points = json['points'];
    question = json['question'];
    answer_1 = json['answer_1'];
    answer_2 = json['answer_2'];
    answer_3 = json['answer_3'];
    answer_4 = json['answer_4'];
    answer_5 = json['answer_5'];
    correct_answer = json['correct_answer'];
    date = json['date'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['question_id'] = question_id;
    json['exam_id'] = exam_id;
    json['question_no'] = question_no;
    json['points'] = points;
    json['question'] = question;
    json['answer_1'] = answer_1;
    json['answer_2'] = answer_2;
    json['answer_3'] = answer_3;
    json['answer_4'] = answer_4;
    json['answer_5'] = answer_5;
    json['correct_answer'] = correct_answer;
    json['date'] = date;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
