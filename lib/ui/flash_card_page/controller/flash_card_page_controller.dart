import 'package:get/state_manager.dart';

import '../../../models/courses_dedails/flashcard.model.dart';

class FlashCardPageController extends GetxController {
  List<FlashCardModel> flashCards;
  final int initCard;
  late int currentCard;
  late bool cardEnd;
  int understand = 0, dontUnderstand = 0;
  bool isFlashcardFinished = false;

  FlashCardPageController({
    required this.flashCards,
    this.initCard = 0,
  }) {
    currentCard = initCard;
    cardEnd = false;
  }

  updateCurrentCard(int? index) {
    if (index != null) {
      currentCard = index;
    } else {
      isFlashcardFinished = true;
    }
    update();
  }

  chnageUnderstand(int i) {
    understand += i;
    update();
  }

  chnageDontUnderstand(int i) {
    dontUnderstand += i;
    update();
  }

  isCardEnd(bool isEnd) {
    cardEnd = isEnd;
    update();
  }
}
