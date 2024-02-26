import 'dart:developer';

import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';

class CommunityGroupRepository {
  static final _api = AppApi();

  //* get group List with current user
  static Future<List<CommunityGroupModel>> get myGroups async {
    Map<String, String> param = {
      "user_id": AppStorage.user.currentUser()!.userId!.toString()
    };

    final res = await _api.getApi(AppUrls.getCommunityGroups, params: param);

    List<CommunityGroupModel> groups = [];
    for (var element in res) {
      final gd = CommunityGroupModel.fromJson(element);
      groups.add(gd);
    }
    return groups;
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
  int? dateJoined;

  GroupMember.fromJson(Map json) {
    groupId = json['group_id'];
    memberId = json['member_id'];
    memberUsername = json['member_username'];
    dateJoined = json['date_joined'];
  }
}
