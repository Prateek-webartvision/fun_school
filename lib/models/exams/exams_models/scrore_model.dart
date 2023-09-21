class ScoreModel {
  int? scoreId;
  String? score;
  String? grade;
  int? dateTaken;

  ScoreModel.fromJson(Map<String, dynamic> json) {
    scoreId = json['score_id'];
    score = json['score'];
    grade = json['grade'];
    dateTaken = json['date_taken'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['score_id'] = scoreId;
    json['score'] = score;
    json['grade'] = grade;
    json['date_taken'] = dateTaken;
    return json;
  }
}
