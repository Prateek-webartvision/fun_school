import 'package:get/get.dart';

import '../../../models/exams/exams_models/multi_choice_quetion_model.dart';

class QuestionAnswerController extends GetxController {
  final List<MultiChoiceQuestion> questions;
  late int index;

  QuestionAnswerController({required int initIndex, required this.questions}) {
    index = initIndex;
  }

  next({
    required void Function() onEnd,
    required void Function() onAnsNotSelected,
  }) {
    if (questions[index].selectedAnswer == null) {
      onAnsNotSelected();
    } else if (index < (questions.length - 1)) {
      index++;
      update();
    } else {
      onEnd();
    }
  }

  selectAnswer({required MultiChoiceQuestion obj, required String ans}) {
    if (obj.selectedAnswer != ans) {
      obj.selectedAnswer = ans;
      update();
    }
  }

  @override
  void dispose() {
    for (var element in questions) {
      element.selectedAnswer = null;
    }
    super.dispose();
  }
}
