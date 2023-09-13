import 'package:flutter/material.dart';

import 'color.dart';

class AppTextStyle {
  static TextStyle get appBarText => const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text16W600 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle get text12W400 => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}

// border1
OutlineInputBorder studyPlanDropBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: AppColor.softBorderColor,
    width: 1,
  ),
);
