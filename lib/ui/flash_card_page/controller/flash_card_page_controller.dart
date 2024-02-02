import 'package:get/state_manager.dart';

import '../../../models/courses_details/flashcard.model.dart';
import '../../../repo/flascard_repo/flashcard_repo.dart';

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
    var flash = flashCards[i];
    flash.copyWith(flashcardResult: true);
    FlashCardRepository.updateFlashCardResult(
        flashCardId: flash.flashcardId!, result: true);
    understand += 1;
    update();
  }

  chnageDontUnderstand(int i) {
    var flash = flashCards[i];
    flash.copyWith(flashcardResult: false);
    FlashCardRepository.updateFlashCardResult(
        flashCardId: flash.flashcardId!, result: false);
    dontUnderstand += 1;
    update();
  }

  isCardEnd(bool isEnd) {
    cardEnd = isEnd;
    update();
  }
}
