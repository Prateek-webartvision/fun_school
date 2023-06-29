import 'package:citycloud_school/repo/quiz_repo/quiz_repo.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class QuizController extends GetxController {
  ApiState apiState = ApiState.loading;
  String error = '';
  List<QuizModel>? quizs;

  QuizController({required String title}) {
    loadQuiz(title);
  }

  int currentQuizIndex = 0;

  setAns(QuizModel q, String ans) {
    q.selectAns(ans);
    update();
  }

  goToNextQuitions() {
    currentQuizIndex++;
    update();
  }

  loadQuiz(String? title) async {
    apiState = ApiState.loading;
    await QuizRepository.getQuiz(title: title ?? "").then((value) {
      quizs = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
