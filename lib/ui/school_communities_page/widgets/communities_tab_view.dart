import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/communities_tab_controller.dart';

class CommunitiesTabView extends StatelessWidget {
  const CommunitiesTabView({super.key, required this.controller, required this.children});
  final CommunitiesTabController controller;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return children[controller.currentIndex];
      },
    );
  }
}
