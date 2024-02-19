// ignore_for_file: prefer_const_constructors

import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    _videoController();

    super.initState();
  }

  _videoController() async {
    videoPlayerController = VideoPlayerController.asset(
      "assets/videos/splash_video/splash2.mp4",
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    await videoPlayerController.initialize();

    videoPlayerController.play();
    videoPlayerController.addListener(() {
      if (!videoPlayerController.value.isPlaying) {
        if (AppStorage.user.currentUser() != null) {
          appRoutes.goNamed(PagesName.homePage);
        } else {
          appRoutes.goNamed(PagesName.startPage);
        }
      }
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayer(videoPlayerController),
    );
  }
}
