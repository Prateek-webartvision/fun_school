class InteractiveQuizModel {
  int? quizId;
  String? type;
  String? courseId;
  String? title;
  String? questionMissionText;
  String? backgroundImage;
  List<QuizData>? quizData;

  InteractiveQuizModel({
    this.quizId,
    this.type,
    this.courseId,
    this.title,
    this.questionMissionText,
    this.backgroundImage,
    this.quizData,
  });

  InteractiveQuizModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    type = json['type'];
    courseId = json['course_id'];
    title = json['title'];
    questionMissionText = json['question_mission_text'];
    backgroundImage = json['background_image'];
    if (json['quiz_data'] != null) {
      quizData = <QuizData>[];
      json['quiz_data'].forEach((v) {
        quizData!.add(QuizData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quiz_id'] = quizId;
    data['type'] = type;
    data['course_id'] = courseId;
    data['title'] = title;
    data['question_mission_text'] = questionMissionText;
    data['background_image'] = backgroundImage;
    if (quizData != null) {
      data['quiz_data'] = quizData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizData {
  int? id;
  String? question;
  bool? correctAnswer;
  String? datePosted;
  bool? seletedAns;

  QuizData({this.id, this.question, this.correctAnswer, this.datePosted});

  QuizData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    if (json['correct_answer'] as int == 0) {
      correctAnswer = false;
    } else {
      correctAnswer = true;
    }
    datePosted = json['date_posted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['date_posted'] = datePosted;
    return data;
  }

  copyWith({bool? seletedAns}) {
    this.seletedAns = seletedAns ?? this.seletedAns;
  }
}
