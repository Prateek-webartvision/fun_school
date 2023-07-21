// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../../../repo/flascard_repo/flashcard_repo.dart';
import '../../../style/color.dart';
import '../../flash_card_page/flash_card_view.dart';
import '../widgets/chapter_tile.dart';
import '../widgets/mission_loading_page.dart';
import '../widgets/subject_state_selector.dart';

enum SubjectState { videos, quiz, flashcard }

class ChaptersTab extends StatelessWidget {
  const ChaptersTab({
    super.key,
    this.subject,
    this.enrollmentData,
    required this.courseID,
    this.courseData,
  });

  final String courseID;
  final CoursesSubject? subject;
  final List<CoursesEnrollment>? enrollmentData;
  final CoursesModel? courseData;

  @override
  Widget build(BuildContext context) {
    if (subject!.subjectContent!.isEmpty) {
      return Center(child: Text("coming soon"));
    } else {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              sliver: SliverToBoxAdapter(
                child: SubjectStateSlector(
                  state: SubjectState.videos,
                  onChange: (state) {
                    if (state == SubjectState.flashcard) {
                      // flashcard
                      AppUtils.showloadingOverlay(() async {
                        final flashcard = await FlashCardRepository.getFlashCards(courseId: int.parse(courseID));
                        if (flashcard != null && flashcard.isNotEmpty) {
                          rootNavigator.currentState!.push(
                            MaterialPageRoute(
                              builder: (context) => FlashCardView(flashCards: flashcard),
                            ),
                          );
                        } else {
                          AppUtils.showSnack("No Flash card");
                        }
                      });
                    } else if (state == SubjectState.quiz) {
                      //Quiz
                      if (AppUtils.isCourseEnroledByMe(enrolls: enrollmentData!)) {
                        appRoutes.pushNamed(
                          PagesName.startQuizPage,
                          queryParameters: {"title": ""},
                          extra: {
                            "subjectId": subject!.subjectId!,
                            "courseId": courseID,
                          },
                        );
                      } else {
                        AppUtils.showSnack("First Enroll The Course");
                      }
                    }
                  },
                ),
              ),
            ),
          ];
        },
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: subject!.subjectContent!.length,
          itemBuilder: (context, index) {
            final chapter = subject!.subjectContent![index];
            // chapter tile
            return Column(
              children: [
                ChapterTile(
                  courseId: courseID,
                  subjectId: subject?.subjectId,
                  title: chapter.first.title!,
                  subjects: chapter,
                  videos: subject!.videos!,
                  enrollmentData: enrollmentData,
                ),
                GestureDetector(
                  onTap: () async {
                    // enroll check
                    if (AppUtils.isCourseEnroledByMe(enrolls: enrollmentData!)) {
                      // addd new page to load and show quiz
                      var res = await rootNavigator.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => KQuizLoadingPage(
                            title: chapter.first.title!,
                            subjectId: subject!.subjectId!,
                            courseId: courseID,
                            index: index + 1,
                          ),
                        ),
                      );
                      // print(res);
                      if (res != null) {
                        AppUtils.showSnack(res);
                      }
                    } else {
                      AppUtils.showSnack("First Enroll The Course");
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration:
                        BoxDecoration(color: AppColor.mainColor.withOpacity(0.2), border: Border.all(color: AppColor.softBorderColor), borderRadius: BorderRadius.vertical(bottom: Radius.circular(6))),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mission ${NumToWords.convertNumberToIndianWords(index + 1)}".capitalize!,
                          style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Complete mission to unlock next stage",
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => 12.height,
        ),
      );
    }
  }
}
