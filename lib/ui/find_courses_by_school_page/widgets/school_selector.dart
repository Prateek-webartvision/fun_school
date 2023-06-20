import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../controller/school_selector_controller.dart';
import 'collage_card.dart';

class SchoolSelector extends StatelessWidget {
  const SchoolSelector({
    super.key,
    required this.controller,
  });

  final SchoolSelectorController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: controller.schools.length,
          itemBuilder: (context, index) {
            return CollageCard(
              name: controller.schools[index]['name'],
              icon: controller.schools[index]['icon'],
              isSelected: (controller.schoolSeletedIndex == index),
              onSelect: () {
                controller.changeSchool(index);
              },
            );
          },
          separatorBuilder: (context, index) => 10.width,
        );
      },
    );
  }
}
