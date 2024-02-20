import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class ChatController extends GetxController {
  late ApiState state;
  late Timer timer;

  ChatController() {
    log("message");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _LoopLoadData();
    });
  }

  _LoopLoadData() {
    // if (state != ApiState.loading) {
    //   state = ApiState.loading;
    // } else {
    //   Future.delayed(Duration(seconds: 2));
    log(timer.tick.toString());
    // state = ApiState.success;
    // }
    update();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
