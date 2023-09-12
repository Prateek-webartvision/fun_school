import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../controller/analysis_chip_controller.dart';
import 'analysis_chip.dart';

class AnalysisChipView extends StatelessWidget {
  const AnalysisChipView({
    super.key,
    required this.controller,
    required this.chips,
  });

  final AnalysisChipController controller;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: GetBuilder(
        init: controller,
        autoRemove: false,
        builder: (cnt) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: chips.length,
            itemBuilder: (context, index) {
              return AnalysisChip(
                text: chips[index],
                isActive: (index == cnt.currentIndex) ? true : false,
                onClick: () {
                  if (cnt.currentIndex != index) {
                    cnt.currentIndex = index;
                  }
                },
              );
            },
            separatorBuilder: (context, index) => 4.width,
          );
        },
      ),
    );
  }
}
