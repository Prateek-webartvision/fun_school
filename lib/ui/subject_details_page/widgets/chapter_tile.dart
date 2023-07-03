// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/subject_video_list_page/subject_video_list_page.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/courses.model.dart';
import '../../../models/courses_dedails/flashcard.model.dart';
import '../../../models/courses_dedails/subject.model.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../../flash_card_page/flash_card_view.dart';
import '../tab_pages/chapter_tab.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    super.key,
    required this.title,
    required this.subjects,
    required this.state,
    required this.flashCard,
    required this.videos,
    this.subjectId,
    this.enrollmentData,
  });
  final String title;
  final List<SubjectContent> subjects;
  final List<FlashCardModel> flashCard;
  final List<ContentVideo> videos;
  final SubjectState state;
  final int? subjectId;
  final List<CoursesEnrollment>? enrollmentData;

  getFlashCards(String subTitle) {
    return flashCard.where((element) => element.subTitle!.contains(subTitle)).toList();
  }

  getVideos(String subTitle) {
    return videos.where((element) => element.subTitle!.contains(subTitle)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          //top
          Container(
            height: 44,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      // "Solving equations & inequalities",
                      text: title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: (state == SubjectState.quiz)
                          ? [
                              TextSpan(text: " "),
                              TextSpan(
                                text: "( start quiz )".capitalize,
                                style: TextStyle(fontSize: 12),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),

                // time
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.textFeildBorderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "1 hours",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          // List of similer subjects with diffrent sub title
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (AppUtils.isCourseEnroledByMe(enrolls: enrollmentData!)) {
                    // Flash card
                    if (state == SubjectState.flashcard) {
                      final flashCards = getFlashCards(subjects[index].subTitle!);
                      if (flashCards.isEmpty) {
                        AppUtils.showSnack("No Flash card");
                      } else {
                        rootNavigator.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => FlashCardView(flashCards: flashCards),
                          ),
                        );
                      }
                    }
                    // for video
                    if (state == SubjectState.videos) {
                      final videos = getVideos(subjects[index].subTitle!);

                      if (videos.isEmpty) {
                        AppUtils.showSnack("No Videos");
                      } else {
                        rootNavigator.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => SubjectVideoListPage(
                              videos: videos,
                              subjectId: subjectId,
                              contentTitle: subjects[index].title!,
                            ),
                          ),
                        );
                      }
                    }
                  } else {
                    AppUtils.showSnack("First Enroll The Course");
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      (state == SubjectState.videos)
                          ? Icons.play_circle_fill_rounded
                          : (state == SubjectState.flashcard)
                              ? Icons.card_giftcard
                              : Icons.info_rounded,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                    4.width,
                    Text(
                      // "Overview and history algebra",
                      subjects[index].subTitle!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => 16.height,
          ),
          10.height,
        ],
      ),
    );
  }
}
