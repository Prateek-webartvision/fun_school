import 'dart:async';
import 'dart:developer';

import 'package:fun_school/repo/chat_repo/chat_repo.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../chat_page.dart';

class MessagesByUserController extends GetxController {
  final String receiverID;
  ApiState? state;
  String? error;
  List<ChatMessageModel> messages = [];

  late Timer timer;
  MessagesByUserController({required this.receiverID}) {
    initLoad();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      reLoad();
    });
  }

  Future<void> initLoad() async {
    state = ApiState.loading;
    update();
    await _loadChat();
  }

  Future<void> reLoad() async {
    await _loadChat();
  }

  _loadChat() async {
    try {
      final res = await ChatRepository.getAllMessagesByUser(receiverID);
      state = ApiState.success;
      messages = res;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
