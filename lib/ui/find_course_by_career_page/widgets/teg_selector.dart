// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';

class TagSelector extends StatelessWidget {
  const TagSelector({
    super.key,
    this.selected = false,
    required this.title,
    this.onChanged,
  }) : assert(selected != null);
  final bool? selected;
  final String title;
  final Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onChanged != null) ? () => onChanged!(!selected!) : null,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: (selected == true) ? AppColor.mainColor : AppColor.white,
          border: (selected != true) ? Border.all(color: AppColor.softBorderColor) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: (selected != true) ? Color(0xff192325) : AppColor.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
