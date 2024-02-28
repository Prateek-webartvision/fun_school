import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/chat_repo/chat_repo.dart';

class AllUsersController extends GetxController {
  ApiState? state;
  String? error;
  List<UserForChat> users = [];
  List<UserForChat> _users = [];
  AllUsersController() {
    initLoad();
  }

  search(String search) {
    final users = _users.where((element) =>
        element.username!.toLowerCase().contains(search.toString()));

    if (search.isEmpty) {
      this.users = _users;
    } else {
      this.users = users.toList();
    }
    update();
  }

  Future<void> initLoad() async {
    state = ApiState.loading;
    update();
    await _load();
  }

  Future<void> reLoad() async {
    await _load();
  }

  _load() async {
    try {
      _users = await ChatRepository.getUsersList();
      users = _users;
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }
}
