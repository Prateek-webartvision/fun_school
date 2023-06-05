import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.mainColor,
        ),
        scaffoldBackgroundColor: AppColor.white,
      );
}
