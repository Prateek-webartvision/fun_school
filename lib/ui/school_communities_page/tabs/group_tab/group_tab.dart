// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../router/app_router.dart';
import '../../../school_communities_group_info_page/school_communities_group_info_page.dart';
import '../../widgets/group_tab_tile.dart';

class GroupsTab extends StatelessWidget {
  const GroupsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12, bottom: 10),
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
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              return GroupTabTile(
                onItemClick: () {
                  rootNavigator.currentState!.push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SchoolCommunitiesGroupInfoPage(),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) => 10.height,
          ),
        )
      ],
    );
  }
}
