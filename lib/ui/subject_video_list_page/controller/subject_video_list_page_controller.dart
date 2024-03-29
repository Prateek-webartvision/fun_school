import 'dart:math';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../models/courses_details/subject.model.dart';

class SubjectVideoListPageController extends GetxController {
  late final List<ContentVideo> videos;
  int currentVideo;
  late VideoPlayerController videoPlayerController;
  bool isVideoLoaded = false;
  bool isPlaying = false;
  bool isShowingPlaySeekBar = false;

  SubjectVideoListPageController(
      {required this.videos, this.currentVideo = 0}) {
    _loadVideo();
  }

  updateVideoList({required List<ContentVideo> newVideos}) {
    videos = newVideos;
    currentVideo = 0;
    _loadVideo();
  }

  _loadVideo() async {
    final videoLink = videos[currentVideo].videoLink!.toString();

    if (isVideoLoaded == true) {
      isVideoLoaded = false;
      isPlaying = false;
      videoPlayerController.dispose();
      update();
    }

    videoPlayerController = VideoPlayerController.contentUri(
      Uri.parse(videoLink),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    await videoPlayerController.initialize().then((value) {
      isVideoLoaded = true;
      videoPlayerController.play();
      isShowingPlaySeekBar = true;
      update();
    });

    videoPlayerController.addListener(() {
      isPlaying = videoPlayerController.value.isPlaying;
      // print(videoPlayerController.value.);
      // print(" dasd = ${videoPlayerController.value.position.inSeconds / videoPlayerController.value.duration.inSeconds}");
      // if (videoPlayerController.value.position.inSeconds / videoPlayerController.value.duration.inSeconds == 1) {
      //   AppUtils.showSnack("Video Ended plase click 'next to'");
      // }
      update();
    });
  }

  playBar() {
    if (isShowingPlaySeekBar) {
      isShowingPlaySeekBar = false;
    } else {
      isShowingPlaySeekBar = true;
      _seekbarTimer();
    }
    update();
  }

  _seekbarTimer() async {
    await Future.delayed(const Duration(seconds: 5));
    isShowingPlaySeekBar = false;
    update();
  }

  onNextVideo({required Function() onVideoEnded}) {
    if (currentVideo < (videos.length - 1)) {
      currentVideo += 1;
      _loadVideo();
      update();
    } else {
      onVideoEnded();
    }
  }

  playPouse() {
    if (isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  seekForword10Sec() async {
    var crrentDuration = videoPlayerController.value.position;
    await videoPlayerController
        .seekTo(Duration(seconds: crrentDuration.inSeconds + 10));
  }

  seekbackword10Sec() async {
    var crrentDuration = videoPlayerController.value.position;
    await videoPlayerController
        .seekTo(Duration(seconds: crrentDuration.inSeconds - 10));
  }

  int get randomNumber {
    return Random().nextInt(videos.length);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
