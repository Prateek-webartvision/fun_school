// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';

class AnalysisChip extends StatelessWidget {
  const AnalysisChip({
    super.key,
    required this.text,
    required this.isActive,
    required this.onClick,
  });
  final String text;
  final bool isActive;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: (isActive) ? AppColor.mainColor.withOpacity(0.10) : Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: (isActive) ? AppColor.mainColor : AppColor.tegTextColor,
          ),
        ),
      ),
    );
  }
}
