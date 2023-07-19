// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class CollageCard extends StatelessWidget {
  const CollageCard({
    super.key,
    required this.name,
    required this.icon,
    this.isSelected = false,
    this.onSelect,
  });
  final String name;
  final IconData icon;
  final bool isSelected;
  final Function()? onSelect;

  final double width = 392.7272;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (onSelect != null) ? () => onSelect!(isSelected) : null,
      onTap: onSelect,
      child: Container(
        // width: 130,
        constraints: BoxConstraints(minWidth: 130, maxWidth: 140),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (isSelected) ? AppColor.pinkColor.withOpacity(0.1) : Colors.white,
          border: Border.all(color: (isSelected) ? AppColor.pinkColor : AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.mainColor,
              radius: 15,
              child: Icon(
                icon,
                color: Colors.white,
                size: 12,
              ),
            ),
            6.height,
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textScaleFactor: context.screenWidth / width,
            ),
          ],
        ),
      ),
    );
  }
}
