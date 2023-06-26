import 'package:flutter/material.dart';

import 'controller/flash_card_page_controller.dart';
import 'flash_card_view.dart';

abstract class FlashCardState extends State<FlashCardView> {
  late FlashCardPageController flashCardPageController;
  @override
  void initState() {
    flashCardPageController = FlashCardPageController(flashCards: widget.flashCards);
    super.initState();
  }

  @override
  void dispose() {
    flashCardPageController.dispose();
    super.dispose();
  }
}
