import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/quiz_repo/quiz_repo.dart';

class QuizController extends GetxController {
  ApiState apiState = ApiState.loading;
  String error = '';
  List<QuizModel>? quizs;
  final int misstionIdex;

  QuizController({String? title, int? subjectId, required this.misstionIdex}) {
    loadQuiz(title: title, subjectId: subjectId);
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

  loadQuiz({String? title, int? subjectId}) async {
    apiState = ApiState.loading;
    await QuizRepository.getQuiz(title: title, quizType: QuizType.quiz, subjectId: subjectId).then((value) {
      quizs = value as List<QuizModel>;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
