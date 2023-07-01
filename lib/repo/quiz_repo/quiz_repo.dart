import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/mock_quiz_model.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';

import '../../network/app_api.dart';

class QuizType {
  static String quiz = "quiz";
  static String mockTest = "mock_test";
}

class QuizRepository {
  static final _api = AppApi();

  static Future getQuiz({required String title, required String quizType}) async {
    return await _api.getApi(AppUrls.getQuizs, params: {"title": title, "type": quizType}).then((value) {
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
}
