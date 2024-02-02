import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';

class CommunityGroupRepository {
  static final _api = AppApi();

  // get group List
  static Future<List<CommunityGroupModel>> getGroups() async {
    Map<String, String> perams = {
      "user_id": AppStorage.user.currentUser()!.userId!.toString()
    };

    return await _api
        .getApi(AppUrls.getcummuityGroups, params: perams)
        .then((value) {
      List<CommunityGroupModel> groups = [];
      for (var element in value) {
        final gd = CommunityGroupModel.fromJson(element);
        groups.add(gd);
      }
      return groups;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class CommunityGroupModel {
  String? userId;
  String? memberAddedBy;
  String? dateJoined;
  String? groupId;
  GroupDetailsModel? groupDetails;

  CommunityGroupModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    memberAddedBy = json['member_added_by'];
    dateJoined = json['date_joined'];
    groupId = json['group_id'];
    groupDetails = GroupDetailsModel.fromJson(json['group_details']);
  }
}

class GroupDetailsModel {
  String? groupName;
  String? description;
  String? course;
  String? topic;
  String? interest;
  String? createdBy;
  String? status;
  String? totalMembers;
  String? dateCreated;
  GroupDetailsModel.fromJson(Map json) {
    groupName = json['group_name'];
    description = json['description'];
    course = json['course'];
    topic = json['topic'];
    interest = json['interest'];
    createdBy = json['created_by'];
    status = json['status'];
    totalMembers = json['total_members'];
    dateCreated = json['date_created'];
  }
}
