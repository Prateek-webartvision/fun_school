import 'package:fun_school/repo/chat_repo/chat_repo.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class ChatUsersController extends GetxController {
  ApiState? state;
  String? error;
  var data;

  ChatUsersController();

  _loadChat() async {
    try {
      final res = await ChatRepository.chatUserList();
    } catch (e) {}
  }
}
