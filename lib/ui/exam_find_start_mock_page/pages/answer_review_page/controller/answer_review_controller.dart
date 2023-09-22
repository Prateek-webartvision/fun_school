part of '../answer_review_page.dart';

class _AnswerReviewController extends GetxController {
  late int index;
  final List<MultiChoiceQuestion> questions;

  late PageController page;

  _AnswerReviewController({int initIndex = 0, required this.questions}) {
    index = initIndex;
    page = PageController(initialPage: index);
  }

  next() {
    if (index < questions.length - 1) {
      index++;
      update();
      _pageJump();
    }
  }

  previous() {
    if (index >= 1) {
      index--;
      update();
      _pageJump();
    }
  }

  _pageJump() {
    page.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
