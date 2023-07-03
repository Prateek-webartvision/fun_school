import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../../../uitls/app_utils.dart';

class SubjectVideoListPageController extends GetxController {
  final List<ContentVideo> videos;
  int currentVideo;
  late VideoPlayerController videoPlayerController;
  bool isVideoLoaded = false;
  bool isplaying = false;
  bool isShowingPlaySeekBar = false;

  SubjectVideoListPageController({required this.videos, this.currentVideo = 0}) {
    _loadVideo();
  }

  _loadVideo() async {
    final videoLink = videos[currentVideo].videoLink!.toString();

    if (isVideoLoaded == true) {
      isVideoLoaded = false;
      videoPlayerController.dispose();
      isplaying = false;
      update();
    }

    videoPlayerController = VideoPlayerController.contentUri(
      Uri.parse(videoLink),
      videoPlayerOptions: VideoPlayerOptions(),
    );

    await videoPlayerController.initialize().then((value) {
      isVideoLoaded = true;
      videoPlayerController.play();
      isplaying = true;
      isShowingPlaySeekBar = true;
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

  onNextVideo() {
    if (currentVideo < (videos.length - 1)) {
      currentVideo += 1;
      _loadVideo();
      update();
    } else {
      AppUtils.showSnack("This is last video");
    }
  }

  playPouse() {
    if (isplaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    isplaying = !isplaying;
    update();
  }

  seekForword10Sec() async {
    var crrentDuration = await videoPlayerController.position;
    videoPlayerController.seekTo(
      Duration(seconds: crrentDuration!.inSeconds + 10),
    );
  }

  seekbackword10Sec() async {
    var crrentDuration = await videoPlayerController.position;
    videoPlayerController.seekTo(
      Duration(seconds: crrentDuration!.inSeconds - 10),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
