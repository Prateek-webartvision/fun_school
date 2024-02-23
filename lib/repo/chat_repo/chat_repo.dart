import 'dart:developer';

import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';
import 'package:fun_school/ui/chat_page/chat_page.dart';

class ChatRepository {
  static final _api = AppApi();

  //* chat User List
  static Future<List<ChatUsersModel>> chatUserList() async {
    Map<String, String> params = {};
    params['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";

    // log(params.toString(), name: "api");
    final res = await _api.getApi(AppUrls.chatUsers, params: params);

    if (res != null) {
      List<ChatUsersModel> temp = [];

      for (var element in res) {
        final data = ChatUsersModel.fromJson(element);
        temp.add(data);
      }
      return temp;
    } else {
      throw "got some error";
    }
  }

  //* get All message by user
  static Future<List<ChatMessageModel>> getAllMessagesByUser(
      String receiverID) async {
    Map<String, dynamic> param = {};
    param['sent_by'] = AppStorage.user.current?.userId?.toString() ?? "";
    param['sent_to'] = receiverID;

    final res = await _api.postApi(AppUrls.allChatsByUser, params: param);

    if (res != null) {
      List<ChatMessageModel> temp = [];
      for (var element in res) {
        final ChatMessageModel messageModel =
            ChatMessageModel.fromJson(element);
        temp.add(messageModel);
      }
      return temp;
    } else {
      throw "got some error";
    }
  }

  // * send message
  static Future sendMessage({
    required String receiverID,
    required String message,
  }) async {
    Map<String, dynamic> param = {};
    param['sent_by'] = AppStorage.user.current?.userId?.toString() ?? "";
    param['sent_to'] = receiverID;
    param['message'] = message;

    await _api.postApi(AppUrls.sendMessage, params: param);
  }

  // * user List to start new chat
  static Future<List<User>> getUsersList() async {
    Map<String, String> param = {};
    param['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";

    final res = await _api.getApi(AppUrls.allUsersById, params: param);

    List<User> temp = [];
    for (var element in res) {
      final User user = User.fromJson(element);
      temp.add(user);
    }
    return temp;
  }
}

class ChatUsersModel {
  String? chatId;
  String? sendBy;
  String? sendTo;
  String? lastMessage;
  int? lastMessageTime;
  String? username;
  String? profileImage;
  String? newMessage;
  int? time;

  ChatUsersModel.fromJson(json) {
    chatId = json['chat_id'];
    sendBy = json['send_by'];
    sendTo = json['send_to'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    username = json['username'];
    profileImage = json['profile_image'];
    newMessage = json['new_message'];
    time = json['time'];
  }
}

//users
class User {
  String? userId;
  String? username;
  String? userProfileImage;
  String? email;
  // String? about;
  // String? userType;
  // String? posts;
  // String? followers;
  // String? following;
  // int? regDate;

  User({
    this.userId,
    this.username,
    this.userProfileImage,
    this.email,
    // this.about,
    // this.userType,
    // this.posts,
    // this.followers,
    // this.following,
    // this.regDate,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    userProfileImage = json['user_profile_image'];
    email = json['email'];
    // about = json['about'];
    // userType = json['user_type'];
    // posts = json['posts'];
    // followers = json['followers'];
    // following = json['following'];
    // regDate = json['reg_date'];
  }
}
