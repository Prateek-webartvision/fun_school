// ignore_for_file: prefer_const_constructors

import 'package:fun_school/ui/profile_page_other/controller/other_profile_controller.dart';
import 'package:fun_school/ui/school_communities_page/tabs/discussion_tab/widgets/text_post_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repo/community/community_discussion_repo.dart';
import '../../../utils/app_utils.dart';

class PostTab extends StatelessWidget {
  const PostTab({
    super.key,
    required this.controller,
  });
  final OtherProfileController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (cnt) {
        return ListView.separated(
          itemCount: cnt.data!.discussions!.length,
          itemBuilder: (context, index) {
            final item = cnt.data!.discussions![index];

            return DiscussionPostTile(
              profileUrl: cnt.data!.profileImage,
              userName: cnt.data!.username!,
              time: DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(item.time!) * 1000000)
                  .toString(),
              type: item.type!,
              userType: cnt.data!.userType!,
              isVerify: cnt.data!.userType == "Certified_Tutor",
              topic: item.topic,
              message: item.text,
              media: item.media,
              first2Likes: item.likes,
              likes: item.likesCount,
              replies: item.replyCount,
              isLiked: item.isLiked,
              onLikeClick: () {
                // call like api
                AppUtils.showLoadingOverlay(() async {
                  await CommunityDiscussionRepository.likeDislikeDiscussion(
                      discussionId: item.discussionId.toString());
                  cnt.setLikeDisLike(discussion: item);
                });
              },
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: 0,
          ),
        );
      },
    );
  }
}
