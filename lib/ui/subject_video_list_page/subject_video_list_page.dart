// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/models/courses_dedails/subject.model.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:video_player/video_player.dart';

import 'controller/subject_video_list_page_controller.dart';

class SubjectVideoListPage extends StatefulWidget {
  const SubjectVideoListPage({
    super.key,
    required this.videos,
  });
  final List<ContentVideo> videos;

  @override
  State<SubjectVideoListPage> createState() => _SubjectVideoListPageState();
}

class _SubjectVideoListPageState extends State<SubjectVideoListPage> {
  late SubjectVideoListPageController subjectVideoListPageController;

  @override
  void initState() {
    subjectVideoListPageController = SubjectVideoListPageController(videos: widget.videos);
    // _loadVideoData();
    super.initState();
  }

  @override
  void dispose() {
    subjectVideoListPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                              size: 30,
                                            ),
                                            4.width,
                                            Text(
                                              "10",
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      16.width,
                                      GestureDetector(
                                        onTap: () {
                                          controller.playPouse();
                                        },
                                        child: Icon(
                                          (controller.isplaying) ? Icons.play_circle_fill_rounded : Icons.pause_circle_filled_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      16.width,
                                      // forwrod seek
                                      GestureDetector(
                                        onTap: () {
                                          controller.seekForword10Sec();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "10",
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            4.width,
                                            Icon(
                                              Icons.keyboard_double_arrow_right_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VideoProgressIndicator(
                            controller.videoPlayerController,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: AppColor.mainColor,
                              backgroundColor: AppColor.white.withOpacity(0.8),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                      onTap: () {
                        controller.onNextVideo();
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
