import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';

import '../../network/app_api.dart';

class QuizRepository {
  static final _api = AppApi();

  static Future<List<QuizModel>> getQuiz({required String title}) async {
    return await _api.getApi(AppUrls.getQuizs, params: {"title": title}).then((value) {
      if (value != null) {
        var quizList = <QuizModel>[];
        for (var element in value) {
          final quiz = QuizModel.fromJson(element);
          quizList.add(quiz);
        }
        return quizList;
      } else {
        return <QuizModel>[];
      }
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }
}


    // int c = "a".codeUnitAt(0);
      // int end = "z".codeUnitAt(0);
      // while (c <= end) {
      //   print(String.fromCharCode(c));
      //   c++;
      // }
      // print(c);
