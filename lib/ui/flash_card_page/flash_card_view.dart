// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../models/courses_details/flashcard.model.dart';
import 'flash_card_state.dart';

class FlashCardView extends StatefulWidget {
  const FlashCardView({
    super.key,
    required this.flashCards,
  });
  final List<FlashCardModel> flashCards;

  @override
  State<FlashCardView> createState() => _FlashCardViewState();
}

class _FlashCardViewState extends FlashCardState {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: flashCardPageController,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.appTheme.scaffoldBackgroundColor,
            leading: GestureDetector(
              onTap: () => appRoutes.pop(),
              child: Icon(Icons.close),
            ),
            title: Text(
                "${controller.currentCard + 1}/${controller.flashCards.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            centerTitle: true,
            actions: [
              Icon(Icons.settings_outlined),
              16.width,
            ],
          ),

          body: (controller.isFlashcardFinished)
              ? _CardResult(
                  card: controller.flashCards,
                )
              : Column(
                  children: [
                    // states bar
                    Container(
                      height: 50,
                      color: AppColor.white,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFA500).withOpacity(0.1),
                              border: Border.all(color: Color(0xFFFFA500)),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              // "1",
                              controller.dontUnderstand.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFA500),
                              ),
                            ),
                          ),
                          (!controller.isFlashcardFinished)
                              ? Text((controller
                                          .flashCards[controller.currentCard]
                                          .flashcardResult ==
                                      null)
                                  ? ""
                                  : (controller
                                              .flashCards[
                                                  controller.currentCard]
                                              .flashcardResult ==
                                          true)
                                      ? "Understood"
                                      : "Not Understood")
                              : SizedBox(),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Color(0xFF008000).withOpacity(0.1),
                              border: Border.all(color: Color(0xFF008000)),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              // "2",
                              controller.understand.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF008000),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    24.height,
                    // swipeble card

                    SizedBox(
                      height: 532,
                      width: double.maxFinite,
                      // child: Text(controller.flashCards.first.flashcardImageLink.toString()),
                      child: CardSwiper(
                        cardsCount: controller.flashCards.length,
                        initialIndex: controller.initCard,
                        padding: EdgeInsets.all(0),
                        isLoop: false,
                        allowedSwipeDirection:
                            AllowedSwipeDirection.symmetric(horizontal: true),
                        backCardOffset: Offset(0, 0),
                        scale: 1,
                        onSwipe: (previousIndex, currentIndex, direction) {
                          // right swipe
                          if (direction == CardSwiperDirection.right) {
                            controller.chnageUnderstand(previousIndex);
                          }
                          // left swipe
                          if (direction == CardSwiperDirection.left) {
                            controller.chnageDontUnderstand(previousIndex);
                          }
                          controller.updateCurrentCard(currentIndex);

                          return true;
                        },
                        onEnd: () {
                          controller.isCardEnd(true);
                        },
                        cardBuilder: (BuildContext context,
                            int index,
                            int horizontalOffsetPercentage,
                            int verticalOffsetPercentage) {
                          return _fCard(controller.flashCards[index]);
                        },
                      ),
                    ),
                  ],
                ),

          //     //
          bottomNavigationBar: (controller.cardEnd)
              ? null
              : SizedBox(
                  height: 40,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Tap the card to flip it",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.85, 0),
                        child: Icon(Icons.play_circle_fill_rounded),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

Widget _fCard(FlashCardModel flashCard) => Container(
      height: 532,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.softBorderColor,
            offset: Offset(2, 4),
            blurRadius: 2,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.volume_up_rounded),
          ),
          Align(
            alignment: Alignment(0, -0.7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                flashCard.flashcardImageLink!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return CircularProgressIndicator();
                  } else {
                    return child;
                  }
                },
                height: 200,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 232,
              width: double.maxFinite,
              // color: Colors.green,
              child: Text(
                // "Algebra (from Arabic الجبر (al-jabr) 'reunion of broken parts,[1] bonesetting'[2]) is the study of variables and the rules for manipulating these variables in formulas;[3] it is a unifying thread of almost all of mathematics.[4] Elementary algebra deals with the manipulation of variables (commonly represented by Roman letters) as if they were numbers and is therefore essential in all applications of mathematics. Abstract algebra is the name given, mostly in education, to the study of algebraic structures such as groups, rings, and fields. Linear algebra, which deals with linear equations and linear mappings, is used for modern presentations of geometry, and has many practical applications (in weather forecasting, for example). There are many areas of mathematics that belong to algebra, some having \"algebra\" in their name, such as commutative algebra, and some not, such as Galois theory.",
                flashCard.flashcardContent ?? "N/A",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
                softWrap: true,
                maxLines: 10,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );

class _CardResult extends StatelessWidget {
  const _CardResult({
    // super.key,
    required this.card,
  });
  final List<FlashCardModel> card;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: card.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Center(child: _fCard(card[index]));
              },
            );
          },
          tileColor: Colors.white,
          // textColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (card[index].flashcardResult == true)
                    ? "Understood"
                    : "Not Understood",
                style: TextStyle(
                    color: (card[index].flashcardResult == true)
                        ? Colors.green
                        : Colors.red),
              ),
              Text("ID: ${card[index].flashcardId!.toString()}"),
            ],
          ),
          subtitle: Text(
            card[index].flashcardContent!,
            style: TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
    );
  }
}
