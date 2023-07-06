import 'package:citycloud_school/network/data/app_storage.dart';
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

  static Future getQuiz({
    String? title,
    required String quizType,
    int? courseId,
  }) async {
    Map<String, String> data = {"type": quizType};
    if (title != null) {
      data["title"] = title;
    }
    if (courseId != null) {
      data['course_id'] = courseId.toString();
    }

    print(data);

    return await _api.getApi(AppUrls.getQuizs, params: data).then((value) {
      print("ca;;");
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
  }) async {
    Map<String, String> data = {};
    data['user_id'] = AppStorage.user.currentUser()!.userid.toString();
    data['type'] = type;
    data['title'] = title;
    data['subject_id'] = subjectid;
    data['score'] = score;

    await _api.postApi(AppUrls.addQuizScore, params: data).then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
