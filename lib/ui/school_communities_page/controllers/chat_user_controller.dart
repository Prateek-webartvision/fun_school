import 'dart:developer';

import 'package:fun_school/repo/chat_repo/chat_repo.dart';
import 'package:get/get.dart';

class ChatUserController extends GetxController {
  ChatUserController() {
    _loadData();
  }

  _loadData() async {
    log("message");
    try {
      final res = await ChatRepository.chatUserList();
    } catch (e) {}
  }
}
