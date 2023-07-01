import 'package:citycloud_school/repo/quiz_repo/quiz_repo.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/mock_quiz_model.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class MockQuizController extends GetxController {
  ApiState apiState = ApiState.loading;
  String error = '';
  List<MockQuizModel>? quizs;

  MockQuizController({required String title}) {
    loadQuiz(title);
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

  loadQuiz(String? title) async {
    apiState = ApiState.loading;
    await QuizRepository.getQuiz(title: title ?? "", quizType: QuizType.mockTest).then((value) {
      quizs = value as List<MockQuizModel>;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
