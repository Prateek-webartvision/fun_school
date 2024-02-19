import 'package:fun_school/repo/quiz_repo/quiz_repo.dart';
import 'package:fun_school/ui/start_quiz_pages/model/mock_quiz_model.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class MockQuizController extends GetxController {
  ApiState apiState = ApiState.loading;
  String error = '';
  List<MockQuizModel>? quizs;

  MockQuizController({String? title, int? courseID}) {
    loadQuiz(title: title, courseId: courseID);
  }

  int currentQuizIndex = 0;

  setAns(MockQuizModel q, String ans) {
    q.selectAns(ans);
    update();
  }

  goToNextQuitions() {
    currentQuizIndex++;
    update();
  }

  loadQuiz({String? title, int? courseId}) async {
    apiState = ApiState.loading;
    await QuizRepository.getQuiz(title: title, subjectId: courseId, quizType: QuizType.mockTest).then((value) {
      quizs = value as List<MockQuizModel>;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
