import 'dart:async';

import 'package:fun_school/repo/chat_repo/chat_repo.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class ChatUserController extends GetxController {
  ApiState? state;
  String? error;
  List<ChatUsersModel>? users;

  ChatUserController() {
    initLoad();
  }

  Future<void> initLoad() async {
    state = ApiState.loading;
    update();
    await _loadData();
  }

  Future<void> reLoad() async {
    await _loadData();
  }

  _loadData() async {
    try {
      final res = await ChatRepository.chatUserList();
      state = ApiState.success;
      users = res;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }
}
