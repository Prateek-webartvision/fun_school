// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../tab_pages/chapter_tab.dart';

class SubjectStateSlector extends StatelessWidget {
  const SubjectStateSlector({
    super.key,
    required this.state,
    required this.onChange,
  });
  final SubjectState state;
  final Function(SubjectState state) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 70,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 0.50,
          color: Color(0xFFDEDEDE),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // video card
          GestureDetector(
            onTap: () {
              onChange(SubjectState.videos);
            },
            child: Container(
              color: Colors.white,
              height: double.maxFinite,
              width: 105,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    color: (state == SubjectState.videos) ? AppColor.mainColor : Color(0xff192325).withOpacity(0.7),
                    // size: 18,
                  ),
                  4.height,
                  Text(
                    "Videos",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: (state == SubjectState.videos) ? AppColor.mainColor : Color(0xff192325).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // flash card
          GestureDetector(
            onTap: () {
              onChange(SubjectState.flashcard);
            },
            child: Container(
              color: Colors.white,
              height: double.maxFinite,
              width: 105,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.card_giftcard,
                    color: (state == SubjectState.flashcard) ? AppColor.mainColor : Color(0xff192325).withOpacity(0.7),
                    // size: 18,
                  ),
                  4.height,
                  Text(
                    "Flash Card",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: (state == SubjectState.flashcard) ? AppColor.mainColor : Color(0xff192325).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // quiz card
          GestureDetector(
            onTap: () {
              onChange(SubjectState.quiz);
            },
            child: Container(
              color: Colors.white,
              height: double.maxFinite,
              width: 105,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: (state == SubjectState.quiz) ? AppColor.mainColor : Color(0xff192325).withOpacity(0.7),
                    // size: 18,
                  ),
                  4.height,
                  Text(
                    "Mock Test",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: (state == SubjectState.quiz) ? AppColor.mainColor : Color(0xff192325).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
