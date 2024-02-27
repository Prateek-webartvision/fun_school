import 'package:fun_school/repo/community/community_group_repo.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class GroupMessageController extends GetxController {
  ApiState? state;
  String? error;
  List<GroupMessage> messages = [];

  final String groupID;

  GroupMessageController(this.groupID) {
    initLoad;
  }

  Future<void> get initLoad async {
    state = ApiState.loading;
    update();
    await _load();
  }

  Future<void> get reLoad async {
    await _load();
  }

  _load() async {
    try {
      messages = await CommunityGroupRepository.groupMessages(groupID);
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }
}

class GroupMessage {
  String? groupId;
  String? messageType;
  String? text;
  String? media;
  String? userId;
  String? messageOwnerUsername;
  String? messageOwnerProfile;
  String? dateSent;

  GroupMessage.fromJson(json) {
    groupId = json['group_id'];
    messageType = json['message_type'];
    text = json['text'];
    media = json['media'];
    userId = json['user_id'];
    messageOwnerUsername = json['message_owner_username'];
    messageOwnerProfile = json['message_owner_profile'];
    dateSent = json['date_sent'];
  }
}
