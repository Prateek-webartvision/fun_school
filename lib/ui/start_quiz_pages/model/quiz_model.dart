class QuizModel {
  int? quizId;
  String? subjectId;
  String? title;
  String? questionTitle;
  List<QuizData>? quizData;
  bool? isAllCurrect;

  QuizModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    //  = json['type'];
    subjectId = json['subject_id'];
    title = json['title'];
    questionTitle = json['question_title'];
    if (json['quiz_data'] != null) {
      var temp = <QuizData>[];
      for (var element in json['quiz_data']) {
        final quizData = QuizData.fromJson(element);
        temp.add(quizData);
      }
      quizData = temp;
    }
    isAllCurrect = false;
  }

  copyWith({bool? isCurrent}) {
    isAllCurrect = isCurrent ?? isAllCurrect;
  }
}

class QuizData {
  int? id;
  String? question;
  String? correctAnswer;
  String? datePosted;
  String? selectedAns;

  QuizData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    correctAnswer = json["correct_answer"];
    datePosted = json["date_posted"];
  }

  copyWith({String? selectedAns}) {
    this.selectedAns = selectedAns ?? this.selectedAns;
  }
}
