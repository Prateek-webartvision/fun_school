import 'package:get/state_manager.dart';

import '../../../models/courses_dedails/subject.model.dart';

class FlashCardPageController extends GetxController {
  List<SubjectContent> subjectContents;
  final int initCard;
  late int currentCard;
  late bool cardEnd;

  FlashCardPageController({
    required this.subjectContents,
    this.initCard = 0,
  }) {
    currentCard = initCard;
    cardEnd = false;
  }

  updateCurrentCard(int index) {
    currentCard = index;
    update();
  }

  isCardEnd(bool isEnd) {
    cardEnd = isEnd;
    update();
  }
}
