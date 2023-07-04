import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/quiz_repo/quiz_repo.dart';

class QuizController extends GetxController {
  ApiState apiState = ApiState.loading;
  String error = '';
  List<QuizModel>? quizs;

  QuizController({String? title, int? courseID}) {
    loadQuiz(title: title, courseId: courseID);
  }

  int currentQuizIndex = 0;

  goToNextQuitions() {
    currentQuizIndex++;
    update();
  }

  changeAns({required int quizDataIndex, required String selectedAns}) {
    quizs![currentQuizIndex].quizData![quizDataIndex].copyWith(selectedAns: selectedAns);
    update();
    // print("object $selectedAns");
  }

  loadQuiz({String? title, int? courseId}) async {
    apiState = ApiState.loading;
    await QuizRepository.getQuiz(title: title, quizType: QuizType.quiz, courseId: courseId).then((value) {
      quizs = value as List<QuizModel>;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
