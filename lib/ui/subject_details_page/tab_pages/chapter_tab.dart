// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../../../repo/flascard_repo/flashcard_repo.dart';
import '../../flash_card_page/flash_card_view.dart';
import '../controller/subject_state_controller.dart';
import '../widgets/chapter_tile.dart';
import '../widgets/subject_state_selector.dart';

enum SubjectState { videos, quiz, flashcard }

class ChaptersTab extends StatefulWidget {
  const ChaptersTab({
    super.key,
    this.subject,
    this.enrollmentData,
    required this.courseID,
  });
  final String courseID;
  final CoursesSubject? subject;
  final List<CoursesEnrollment>? enrollmentData;

  @override
  State<ChaptersTab> createState() => _ChaptersTabState();
}

class _ChaptersTabState extends State<ChaptersTab> {
  late SubjectStateController stateController;

  @override
  void initState() {
    stateController = SubjectStateController(state: SubjectState.videos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subject!.subjectContent!.isEmpty) {
      return Center(child: Text("coming soon"));
    } else {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              sliver: SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: stateController,
                  builder: (context, child) {
                    return SubjectStateSlector(
                      state: stateController.state,
                      onChange: (state) {
                        if (state == SubjectState.flashcard) {
                          // flashcard
                          AppUtils.showloadingOverlay(() async {
                            final flashcard = await FlashCardRepository.getFlashCards(courseId: int.parse(widget.courseID));
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
                          if (AppUtils.isCourseEnroledByMe(enrolls: widget.enrollmentData!)) {
                            // print("yes");
                            appRoutes.pushNamed(
                              PagesName.startQuizPage,
                              queryParameters: {
                                // "title": chapter.first.title,
                                "title": "",
                              },
                              extra: {
                                "subjectId": widget.subject!.subjectId!,
                                "courseId": widget.courseID,
                              },
                            );
                          } else {
                            AppUtils.showSnack("First Enroll The Course");
                          }
                          // }
                        } else {
                          stateController.updateState(state);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: widget.subject!.subjectContent!.length,
          itemBuilder: (context, index) {
            final chapter = widget.subject!.subjectContent![index];
            // chapter tile
            return AnimatedBuilder(
              animation: stateController,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () {
                    // // quiz
                    // if (stateController.state == SubjectState.quiz) {
                    //   // print(widget.subject.dateAdded);

                    //   if (AppUtils.isCourseEnroledByMe(enrolls: widget.enrollmentData!)) {
                    //     appRoutes.pushNamed(
                    //       PagesName.startQuizPage,
                    //       queryParameters: {
                    //         "title": chapter.first.title,
                    //       },
                    //       extra: widget.courseID,
                    //     );
                    //   } else {
                    //     AppUtils.showSnack("First Enroll The Course");
                    //   }
                    // }
                  },
                  child: ChapterTile(
                    courseId: widget.courseID,
                    subjectId: widget.subject?.subjectId,
                    title: chapter.first.title!,
                    subjects: chapter,
                    flashCard: widget.subject!.flashCard!,
                    videos: widget.subject!.videos!,
                    state: stateController.state,
                    enrollmentData: widget.enrollmentData,
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) => 12.height,
        ),
      );
    }
  }
}
