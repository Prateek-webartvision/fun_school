// ignore_for_file: avoid_print

import 'package:citycloud_school/models/quiz/interactive_quiz.model.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/mock_quiz_model.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import '../../network/app_api.dart';

class QuizType {
  static String quiz = "quiz";
  static String mockTest = "mock_test";
}

class QuizRepository {
  static final _api = AppApi();

  static Future getQuiz({String? title, required String quizType, int? subjectId}) async {
    Map<String, String> data = {"type": quizType};
    if (title != null) {
      data["title"] = title;
    }
    if (subjectId != null) {
      data['subject_id'] = subjectId.toString();
    }

    return await _api.getApi(AppUrls.getQuizs, params: data).then((value) {
      if (value != null) {
        if (quizType == QuizType.mockTest) {
          var quizList = <MockQuizModel>[];

          for (var element in value) {
            final quiz = MockQuizModel.fromJson(element);
            quizList.add(quiz);
          }
          return quizList;
        } else {
          var quizList = <QuizModel>[];
          for (var element in value) {
            final quiz = QuizModel.fromJson(element);
            quizList.add(quiz);
          }
          return quizList;
        }
      } else {
        return <MockQuizModel>[];
      }
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  // add Quiz score
  static addQuizScore({
    required String type,
    required String title,
    required String subjectid,
    required String score,
    required String courseID,
  }) async {
    Map<String, String> data = {};
    data['user_id'] = AppStorage.user.currentUser()!.userid.toString();
    data['type'] = type;
    data['course_id'] = courseID;
    data['title'] = title;
    data['subject_id'] = subjectid;
    data['score'] = score;

    // print(data);

    await _api.postApi(AppUrls.addQuizScore, params: data).then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  // hget quiz result
  static Future<List<QuizResultModel>?> getAllQuizResults({required String title}) async {
    List<QuizResultModel> res = [];
    await _api.postApi(AppUrls.fetchQuizScore, params: {
      "user_id": AppStorage.user.currentUser()!.userid!.toString(),
    }).then((value) {
      if (value != null) {
        for (var el in value) {
          final results = QuizResultModel.fromJson(el);
          if (results.title == title) {
            res.add(results);
          }
        }
      }
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
    return res;
  }

  static Future<List<InteractiveQuizModel>?> getIntractiveQuiz({required String title}) async {
    return await _api.getApi(AppUrls.getInteractiveQuiz, params: {'title': title}).then((value) {
      List<InteractiveQuizModel> temp = [];
      for (var element in value) {
        final quiz = InteractiveQuizModel.fromJson(element);
        temp.add(quiz);
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class QuizResultModel {
  int? quizScoreId;
  String? subjectId;
  String? title;
  String? quizType;
  String? quizScore;
  String? numberOfTrials;
  String? dateAdded;

  QuizResultModel.fromJson(Map<String, dynamic> json) {
    quizScoreId = json['quiz_score_id'];
    subjectId = json['subject_id'];
    title = json['title'];
    quizType = json['quiz_type'];
    quizScore = json['quiz_score'];
    numberOfTrials = json['number_of_trials'];
    dateAdded = json['date_added'];
  }
}
