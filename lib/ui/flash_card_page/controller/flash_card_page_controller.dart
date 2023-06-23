import 'package:get/state_manager.dart';

import '../../../models/courses_dedails/subject.model.dart';

class FlashCardPageController extends GetxController {
  List<SubjectContent> subjectContents;
  final int initCard;
  late int currentCard;

  FlashCardPageController({
    required this.subjectContents,
    this.initCard = 0,
  }) {
    currentCard = initCard;
  }

  updateCurrentCard(int index) {
    currentCard = index;
  }
}
