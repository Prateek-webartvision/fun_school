import 'dart:developer';

import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';

class ChatRepository {
  static final _api = AppApi();
  // get all Users Chat
  // static allChatsByUsers({required String otherUser}) async {
  //   Map<String, String> params = {};
  //   params['']
  // }

  //* chat User List
  static Future chatUserList() async {
    Map<String, String> params = {};
    params['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";
    log(params.toString(), name: "api");
    //
    final res = await _api.getApi(AppUrls.chatUsers, params: params);

    log(res.toString());
  }
}
