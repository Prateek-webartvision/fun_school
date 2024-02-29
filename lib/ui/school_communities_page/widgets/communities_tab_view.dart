import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/communities_tab_controller.dart';

class CommunitiesTabView extends StatelessWidget {
  const CommunitiesTabView({
    super.key,
    required this.controller,
    required this.children,
    required this.tabController,
  });
  final CommunitiesTabController controller;
  final TabController tabController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return TabBarView(
          controller: tabController,
          children: children,
        );
        // return children[controller.currentIndex];
      },
    );
  }
}
