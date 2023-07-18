// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:citycloud_school/models/courses_dedails/subject.model.dart';
import 'package:citycloud_school/repo/quiz_repo/quiz_repo.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../models/quiz/interactive_quiz.model.dart';
import '../interactive_quiz_page/interactive_quiz_page.dart';
import 'controller/subject_video_list_page_controller.dart';
import 'widgets/more_option_sheets.dart';
import 'widgets/take_note_sheet.dart';

class SubjectVideoListPage extends StatefulWidget {
  const SubjectVideoListPage({
    super.key,
    required this.videos,
    this.subjectId,
    required this.contentTitle,
    required this.courseID,
  });
  final List<ContentVideo> videos;
  final int? subjectId;
  final String contentTitle;
  final String courseID;

  @override
  State<SubjectVideoListPage> createState() => _SubjectVideoListPageState();
}

class _SubjectVideoListPageState extends State<SubjectVideoListPage> {
  late SubjectVideoListPageController subjectVideoListPageController;
  late InteractiveQuizController interactiveQuizController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    subjectVideoListPageController = SubjectVideoListPageController(videos: widget.videos);
    interactiveQuizController = InteractiveQuizController(widget.contentTitle);

    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    subjectVideoListPageController.dispose();
    interactiveQuizController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  // more option click
  onMoreOptionClick({required String subTitle}) async {
    AppUtils.showModelSheet(
      child: MoreMenuSheet(
        playerController: subjectVideoListPageController.videoPlayerController,
        subjectId: widget.subjectId!.toString(),
      ),
      isScrolled: false,
    ).then((value) {
      if (value == "note") {
        scaffoldKey.currentState!.showBottomSheet(
          (context) => TakeNoteSheet(
            courseId: widget.courseID,
            contentTitle: widget.contentTitle,
            subTitle: subTitle,
            subjectId: widget.subjectId!,
            noteTitle: 'Text sub title',
          ),
          enableDrag: true,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        foregroundColor: Colors.white,
        title: Text("Introduction to variables", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: subjectVideoListPageController,
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.playBar();
                  },
                  child: Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: (controller.isVideoLoaded)
                              ? SizedBox(
                                  width: double.maxFinite,
                                  child: AspectRatio(
                                    aspectRatio: controller.videoPlayerController.value.aspectRatio,
                                    child: VideoPlayer(
                                      controller.videoPlayerController,
                                    ),
                                  ),
                                )
                              : CircularProgressIndicator(),
                        ),
                        Visibility(
                          visible: controller.isShowingPlaySeekBar,
                          // visible: true,
                          child: Align(
                            alignment: Alignment.center,
                            child: (controller.isVideoLoaded)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //backword seek
                                      GestureDetector(
                                        onTap: () {
                                          controller.seekbackword10Sec();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.keyboard_double_arrow_left_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            4.width,
                                            Text(
                                              "10",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      20.width,
                                      GestureDetector(
                                        onTap: () {
                                          controller.playPouse();
                                        },
                                        child: Icon(
                                          (controller.isplaying) ? Icons.play_circle_fill_rounded : Icons.pause_circle_filled_rounded,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                      20.width,
                                      // forwrod seek
                                      GestureDetector(
                                        onTap: () {
                                          controller.seekForword10Sec();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "10",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            4.width,
                                            Icon(
                                              Icons.keyboard_double_arrow_right_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ),
                        ),
                        // botom bar with mode option btn

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (!subjectVideoListPageController.videoPlayerController.value.isInitialized)
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          // more option widget
                                          GestureDetector(
                                            onTap: () => onMoreOptionClick(subTitle: controller.videos[controller.currentVideo].subTitle!),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 32,
                                                  width: 32,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.white,
                                                    borderRadius: BorderRadius.circular(32),
                                                    border: Border.all(color: AppColor.softBorderColor),
                                                  ),
                                                  child: Icon(Icons.more_horiz_rounded),
                                                ),
                                                4.height,
                                                Text(
                                                  "Menu",
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColor.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                              2.height,
                              SizedBox(
                                height: 12,
                                child: VideoProgressIndicator(
                                  controller.videoPlayerController,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    playedColor: AppColor.mainColor,
                                    backgroundColor: AppColor.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // bottom next
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${controller.videos[controller.currentVideo].subTitle}"),
                    GestureDetector(
                      onTap: () async {
                        InteractiveQuizModel? result;
                        final randomQuiz = interactiveQuizController.getRandomQuiz();

                        if (randomQuiz != null) {
                          controller.videoPlayerController.pause();
                          result = await rootNavigator.currentState!.push<InteractiveQuizModel>(
                            MaterialPageRoute(
                              builder: (context) => InteractiveQuizPage(
                                quizModel: randomQuiz,
                              ),
                            ),
                          );
                          controller.videoPlayerController.play();
                        } else {
                          controller.onNextVideo();
                        }

                        if (result != null) {
                          var v = interactiveQuizController.addToViewed(quiz: result);

                          if (v == true) {
                            if (controller.currentVideo < controller.videos.length - 1) {
                              controller.onNextVideo();
                            }
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            "Next to",
                            style: TextStyle(color: AppColor.mainColor),
                          ),
                          Icon(
                            Icons.navigate_next_rounded,
                            color: AppColor.mainColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class InteractiveQuizController extends GetxController {
  List<InteractiveQuizModel>? quizs;
  List<InteractiveQuizModel> viewedQuizs = [];
  int? randomSeed;

  InteractiveQuizController(String title) {
    _loadQuiz(title);
  }

  void _loadQuiz(String title) async {
    QuizRepository.getIntractiveQuiz(title: title).then((value) {
      quizs = value;
    }).onError((error, stackTrace) {
      print(error!);
    });
    update();
  }

  bool addToViewed({required InteractiveQuizModel quiz}) {
    bool allAndRight = false;

    for (var element in quiz.quizData!) {
      // print("${element.correctAnswer} == ${element.seletedAns}");
      if (element.correctAnswer == element.seletedAns) {
        allAndRight = true;
      } else {
        allAndRight = false;
        break;
      }
    }

    if (allAndRight) {
      viewedQuizs.add(quiz);
      randomSeed = null;
      // print("ans r");
    } else {
      randomSeed = quiz.quizId;
    }
    // update();
    return allAndRight;
  }

  getRandomQuiz() {
    var tempQuis = quizs!;
    InteractiveQuizModel? _quiz;

    for (var element in viewedQuizs) {
      tempQuis.remove(element);
    }

    if (tempQuis.isNotEmpty) {
      final index = Random(randomSeed).nextInt(tempQuis.length);
      _quiz = tempQuis[index];
    }

    // print(randomSeed);

    return _quiz;
  }
}
