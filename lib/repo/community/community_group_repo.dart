import 'dart:developer';
import 'dart:io';

import '../../network/app_api.dart';
import '../../network/data/app_storage.dart';
import '../../network/url/app_urls.dart';
import '../../ui/school_communities_group_info_page/controller/group_messages.controller.dart';

class CommunityGroupRepository {
  static final _api = AppApi();

  //* get group List with current user
  static Future<CommunityGroupModel> groupDetailsByID(String id) async {
    Map<String, String> param = {"group_id": id};

    final res = await _api.getApi(AppUrls.getCommunityGroups, params: param);
    List<CommunityGroupModel> groups = [];
    for (var element in res) {
      final gd = CommunityGroupModel.fromJson(element);
      groups.add(gd);
    }
    if (groups.isNotEmpty) {
      return groups.first;
    } else {
      throw "No Data";
    }
  }

  //* all groups
  static Future<List<CommunityGroupModel>> get allOtherGroups async {
    final res = await _api.getApi(AppUrls.getCommunityAllGroups);

    List<CommunityGroupModel> groups = [];
    for (var element in res) {
      final gd = CommunityGroupModel.fromJson(element);
      groups.add(gd);
    }
    return groups;
  }

  //* create new Group
  static Future<void> createNewGroup({
    required String name,
    required String des,
  }) async {
    Map<String, String> param = {};
    param["group_owner_id"] = AppStorage.user.current?.userId?.toString() ?? "";
    param["group_name"] = name;
    param["group_description"] = des;

    await _api.postApi(AppUrls.createNewGroup, params: param);
  }

  // * join and leave group
  static Future<void> joinAndLeaveGroup(
    String groupID, {
    String? userID,
  }) async {
    Map<String, String> param = {};
    param['group_id'] = groupID;
    if (userID != null) {
      param['user_id'] = userID;
    } else {
      param['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";
    }

    final res = await _api.postApi(AppUrls.joinLeaveGroup, params: param);
    if (res['code'] == 200) {
      log(res['message'].toString());
    } else {
      throw res['message'];
    }
  }

  // * Group Messages
  static Future<List<GroupMessage>> groupMessages(String groupId) async {
    Map<String, String> param = {};
    param['group_id'] = groupId;
    // param['group_id'] = "26";
    final res = await _api.getApi(AppUrls.groupMessages, params: param);
    List<GroupMessage> temp = [];
    for (var element in res) {
      GroupMessage msg = GroupMessage.fromJson(element);
      temp.add(msg);
    }
    return temp;
  }

  // * Send Group message
  static Future<void> sendGroupMessage({
    String? message,
    required String groupID,
    String? imagePath,
  }) async {
    Map<String, String> param = {};
    Map<String, List<File>> files = {};

    param['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";
    param['text'] = message ?? "";
    param['group_id'] = groupID;

    if (imagePath != null) {
      files.addAll({
        "images": [File(imagePath)]
      });
    }

    final res = await _api.postWithFiles(
      AppUrls.sendGroupMessage,
      params: param,
      files: files,
    );

    if (res['code'] == 200) {
      log(res["message"].toString());
    } else {
      throw res['message'];
    }
  }

  // * remove member
  static Future<void> removeMember({
    required String groupId,
    required String memberId,
  }) async {
    Map<String, String> param = {};
    param['group_id'] = groupId;
    param['member_id'] = memberId;
    param['user_id'] = AppStorage.user.current?.userId?.toString() ?? "";

    final res = await _api.getApi(AppUrls.groupMemberRemove, params: param);
    if (res['code'] == 200) {
      log(res.toString());
    } else {
      throw res['message'];
    }
  }

  // group meetings
  static Future<List<GroupMeetingModel>> getGroupMeetings(
      String groupID) async {
    Map<String, String> param = {};
    param['group_id'] = groupID;

    final res = await _api.getApi(AppUrls.getGroupMeetings, params: param);
    List<GroupMeetingModel> temp = [];
    for (var element in res) {
      final data = GroupMeetingModel.fromJson(element);
      temp.add(data);
    }
    return temp;

    //
  }
}

class GroupMeetingModel {
  String? meetingId;
  String? groupId;
  String? meetingTitle;
  String? meetingDescription;
  String? meetingDate;
  String? meetingTime;
  String? meetingDuration;
  String? meetingHost;
  String? meetingLink;
  String? meetingStatus;
  int? dateCreated;

  GroupMeetingModel.fromJson(json) {
    meetingId = json['meeting_id'];
    groupId = json['group_id'];
    meetingTitle = json['meeting_title'];
    meetingDescription = json['meeting_description'];
    meetingDate = json['meeting_date'];
    meetingTime = json['meeting_time'];
    meetingDuration = json['meeting_duration'];
    meetingHost = json['meeting_host'];
    meetingLink = json['meeting_link'];
    meetingStatus = json['meeting_status'];
    dateCreated = json['date_created'];
  }
}

class CommunityGroupModel {
  String? groupId;
  String? groupOwnerId;
  String? groupOwnerUsername;
  String? groupName;
  String? description;
  String? totalMembers;
  int? dateCreated;
  List<GroupMember>? groupMembers;

  CommunityGroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupOwnerId = json['group_owner_id'];
    groupOwnerUsername = json['group_owner_username'];
    groupName = json['group_name'];
    description = json['description'];
    totalMembers = json['total_members'];
    dateCreated = json['date_created'];

    if (json['group_members'] != null) {
      List<GroupMember> temp = [];
      for (var element in json['group_members']) {
        final m = GroupMember.fromJson(element);
        temp.add(m);
      }
      groupMembers = temp;
    }
  }
}

class GroupMember {
  String? groupId;
  String? memberId;
  String? memberUsername;
  String? profile;
  int? dateJoined;

  GroupMember.fromJson(Map json) {
    groupId = json['group_id'];
    memberId = json['member_id'];
    memberUsername = json['member_username'];
    profile = json['profile'];
    dateJoined = json['date_joined'];
  }
}
