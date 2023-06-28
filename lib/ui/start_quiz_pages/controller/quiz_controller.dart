import 'package:citycloud_school/repo/quiz_repo/quiz_repo.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  QuizController({String? title}) {
    _loadQuiz(title);
  }

  _loadQuiz(String? title) {
    QuizRepository.getQuiz(title: title);
  }
}
