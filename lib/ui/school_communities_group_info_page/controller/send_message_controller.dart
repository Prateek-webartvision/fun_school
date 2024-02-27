import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/community/community_group_repo.dart';
import '../../../utils/app_utils.dart';
import 'image_picker.controller.dart';

class SendGroupChatController extends GetxController {
  ApiState state = ApiState.success;
  String? error;

  sendMessage({
    required TextEditingController message,
    required ImagePickerController imageCnt,
    required String groupID,
  }) async {
    try {
      if (state != ApiState.loading) {
        state = ApiState.loading;
        update();
        await CommunityGroupRepository.sendGroupMessage(
          message: message.text.trim(),
          imagePath: imageCnt.image?.path,
          groupID: groupID,
        );
        imageCnt.clear();
        message.clear();
        state = ApiState.success;
        update();
      } else {
        throw "Sending";
      }
    } catch (e) {
      AppUtils.showSnack(e.toString());
      state = ApiState.error;
      update();
    }
  }
}
