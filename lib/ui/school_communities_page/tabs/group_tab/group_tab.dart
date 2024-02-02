// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/school_communities_page/controllers/community_group_controller.dart';
import 'package:citycloud_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../router/app_router.dart';
import '../../../school_communities_group_info_page/school_communities_group_info_page.dart';
import '../../widgets/group_tab_tile.dart';

class GroupsTab extends StatelessWidget {
  const GroupsTab({
    super.key,
    required this.controller,
  });
  final CommunityGroupController controller;

  @override
  Widget build(BuildContext context) {
    // controller.initLoad();
    return GetBuilder(
      init: controller,
      builder: (cnt) {
        if (cnt.state == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        // on error
        if (cnt.state == ApiState.error) {
          return ErrorPage(
              error: cnt.error.toString(),
              onError: () {
                cnt.initLoad();
              });
        }

        // on success
        return RefreshIndicator(
          onRefresh: () async {
            await cnt.reLoad();
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 12, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Groups",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      4.height,
                      Text(
                        "Groups are specialized communities tailored to specific courses, topics, or interests.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // group list
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.separated(
                  itemCount: cnt.groups!.length,
                  itemBuilder: (context, index) {
                    final item = cnt.groups![index];
                    return GroupTabTile(
                      title: item.groupDetails?.groupName ?? "N/A",
                      // description: "Dive into the world of physics, from quantum mechanics to classical dynamics.",
                      description: item.groupDetails?.description ?? "N/A",
                      totalMembers: item.groupDetails?.totalMembers ?? "0",
                      datejoinedPoch: item.dateJoined!,
                      onItemClick: () {
                        rootNavigator.currentState!.push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SchoolCommunitiesGroupInfoPage(),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => 10.height,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
