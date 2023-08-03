// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class TagSelector extends StatelessWidget {
  const TagSelector({
    super.key,
    required this.onChanged,
    required this.tagSet,
    required this.currentIndex,
  });
  final int? currentIndex;
  final Set<String> tagSet;
  final Function(int index) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tagSet.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: (currentIndex == index) ? AppColor.mainColor : AppColor.white,
                border: (currentIndex != index) ? Border.all(color: AppColor.softBorderColor) : null,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              alignment: Alignment.center,
              child: Text(
                tagSet.elementAt(index).capitalize!,
                style: TextStyle(
                  color: (currentIndex != index) ? Color(0xff192325) : AppColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => 8.width,
      ),
    );
  }
}
