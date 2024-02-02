// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';

import '../../../models/courses_dedails/courses.model.dart';
import '../../../models/courses_dedails/subject.model.dart';
import '../../../repo/flascard_repo/flashcard_repo.dart';
import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import '../../../style/color.dart';
import '../../../utils/app_utils.dart';
import '../../flash_card_page/flash_card_view.dart';
import '../../interactive_quiz_page/interactive_quiz_page.dart';
import '../../subject_video_list_page/subject_video_list_page.dart';
import '../widgets/subject_state_selector.dart';

enum SubjectState { videos, quiz, flashcard }

class ChaptersTab extends StatefulWidget {
  const ChaptersTab({
    super.key,
    required this.courseData,
    required this.index,
  });

  final CoursesModel courseData;
  final int index;

  @override
  State<ChaptersTab> createState() => _ChaptersTabState();
}

class _ChaptersTabState extends State<ChaptersTab> {
  late ChapterTabController chapterTabController;

  @override
  void initState() {
    chapterTabController = ChapterTabController(
        index: widget.index, courseData: widget.courseData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final subject = widget.courseData!.courseSubjects![widget.index];

    if (chapterTabController.subject.videos!.isEmpty) {
      return Center(child: Text("coming soon"));
    } else {
      // return Text("${subject} + $index");
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              sliver: SliverToBoxAdapter(
                child: SubjectStateSlector(
                  state: SubjectState.videos,
                  onChange: (state) {
                    // print(chapterTabController.courseData.isCourseEnrolled);
                    if (chapterTabController.courseData.isCourseEnrolled) {
                      if (state == SubjectState.flashcard) {
                        // flashcard
                        AppUtils.showLoadingOverlay(() async {
                          final flashcard =
                              await FlashCardRepository.getFlashCards(
                                  courseId: int.parse(chapterTabController
                                      .courseData.courseId!
                                      .toString()));
                          if (flashcard != null && flashcard.isNotEmpty) {
                            // print(flashcard.length);
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    FlashCardView(flashCards: flashcard),
                              ),
                            );
                          } else {
                            AppUtils.showSnack("No Flash card");
                          }
                        });
                      } else if (state == SubjectState.quiz) {
                        //Quiz
                        appRoutes.pushNamed(
                          PagesName.startQuizPage,
                          queryParameters: {"title": ""},
                          extra: {
                            "subjectId": chapterTabController.subject.subjectId,
                            "courseId": chapterTabController
                                .courseData.courseId!
                                .toString(),
                          },
                        );
                      }
                    } else {
                      AppUtils.showSnack("First Enroll The Course");
                    }
                  },
                ),
              ),
            ),
          ];
        },
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: chapterTabController.listVideo!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ChapterTile(
                  isEnrolled: chapterTabController.courseData.isCourseEnrolled,
                  courseId:
                      chapterTabController.courseData.courseId!.toString(),
                  subjectId: chapterTabController.subject.subjectId,
                  title: chapterTabController.listVideo![index].first.title!,
                  videos: chapterTabController.listVideo![index],
                  enrollmentData:
                      chapterTabController.courseData.courseEnrollment,
                  missionIndex: index + 1,
                ),
                //
                GestureDetector(
                  onTap: () async {
                    // enroll check
                    if (chapterTabController.courseData.isCourseEnrolled) {
                      // addd new page to load and show quiz
                      await rootNavigator.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => InteractiveQuizPage(
                            title: chapterTabController
                                .listVideo![index].first.title!,
                            subjectId: chapterTabController.subject.subjectId!,
                            courseId: chapterTabController.courseData.courseId!
                                .toString(),
                            misstionIdex: index + 1,
                          ),
                        ),
                      );
                    } else {
                      AppUtils.showSnack("First Enroll The Course");
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      // color: Color(0xff6232eb),
                      border: Border.all(color: AppColor.softBorderColor),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(6),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mission ${NumToWords.convertNumberToIndianWords(index + 1)}"
                              .capitalize!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Complete mission to unlock next stage",
                          style: TextStyle(
                            color: Colors.white,
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

            // final chapter = subject!.subjectContent![index];
            // chapter tile
            // return Column(
            //   children: [
            //     ChapterTile(
            //       courseId: courseID,
            //       subjectId: subject?.subjectId,
            //       title: chapter.first.title!,
            //       subjects: chapter,
            //       videos: subject!.videos!,
            //       enrollmentData: enrollmentData,
            //       missionIndex: index + 1,
            //     ),
            //     GestureDetector(
            //       onTap: () async {
            //         // enroll check
            //         if (AppUtils.isCourseEnroledByMe(enrolls: enrollmentData!)) {
            //           // addd new page to load and show quiz
            //           await rootNavigator.currentState!.push(
            //             MaterialPageRoute(
            //               builder: (context) => InteractiveQuizPage(
            //                 title: chapter.first.title!,
            //                 subjectId: subject!.subjectId!,
            //                 courseId: courseID,
            //                 misstionIdex: index + 1,
            //               ),
            //             ),
            //           );
            //         } else {
            //           AppUtils.showSnack("First Enroll The Course");
            //         }
            //       },
            //       child: Container(
            //         width: double.maxFinite,
            //         decoration: BoxDecoration(
            //           // color: AppColor.mainColor.withOpacity(0.2),
            //           color: Color(0xfffaefff),
            //           border: Border.all(color: AppColor.softBorderColor),
            //           borderRadius: BorderRadius.vertical(
            //             bottom: Radius.circular(6),
            //           ),
            //         ),
            //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Mission ${NumToWords.convertNumberToIndianWords(index + 1)}".capitalize!,
            //               style: TextStyle(
            //                 // color: Colors.white,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //             Text(
            //               "Complete mission to unlock next stage",
            //               style: TextStyle(
            //                 // color: Colors.white,
            //                 fontSize: 10,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // );
          },
          separatorBuilder: (context, index) => 12.height,
        ),
      );
    }
  }
}

class ChapterTabController {
  final int index;
  late CoursesModel courseData;
  late CoursesSubject subject;
  late List<List<ContentVideo>>? listVideo;

  ChapterTabController({required this.index, required this.courseData}) {
    subject = courseData.courseSubjects![index];
    //
    // sort call
    _sortVideosByTitle();
  }

  _sortVideosByTitle() {
    final videos = subject.videos;

    final videoTitalSet = videos!.map((e) => e.title).toSet();

    List<List<ContentVideo>> temp = [];
    for (var element in videoTitalSet) {
      final vd = videos.where((e) => e.title == element).toList();
      temp.add(vd);
    }

    listVideo = temp;
  }
}

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    super.key,
    required this.title,
    // required this.subjects,
    required this.videos,
    this.subjectId,
    this.enrollmentData,
    required this.courseId,
    required this.missionIndex,
    required this.isEnrolled,
  });
  final String title;
  final String courseId;
  // final List<SubjectContent> subjects;
  final List<ContentVideo> videos;
  final int? subjectId;
  final List<CoursesEnrollment>? enrollmentData;
  final int missionIndex;
  final bool isEnrolled;

  List<ContentVideo> getBelowVideos(int index) {
    final topicSet = videos.map((e) => e.subTitle).toList();

    int detIndex = topicSet.indexOf(videos[index].subTitle);
    List<ContentVideo> belowVideos = [];

    for (int i = detIndex; i < topicSet.length; i++) {
      videos
          .where((element) => element.subTitle! == topicSet[i])
          .toList()
          .forEach((e) {
        belowVideos.add(e);
      });
    }
    return belowVideos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
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
            primary: false,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              // return Text("data");
              return GestureDetector(
                onTap: () {
                  if (isEnrolled) {
                    // final v = getBelowVideos(index);
                    // List<ContentVideo> v = [videos[index]];

                    // print(getBelowVideos(index));

                    rootNavigator.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => SubjectVideoListPage(
                          videos: getBelowVideos(index),
                          subjectId: subjectId,
                          contentTitle: videos[index].title!,
                          courseID: courseId,
                          missionIndex: missionIndex,
                        ),
                      ),
                    );
                  } else {
                    AppUtils.showSnack("First Enroll The Course");
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_fill_rounded,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                    4.width,
                    Text(
                      // "Overview and history algebra",
                      videos[index].subTitle!,
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
