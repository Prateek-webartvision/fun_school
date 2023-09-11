import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
        scaffoldBackgroundColor: AppColor.scaffoldBg,
        textTheme: GoogleFonts.interTextTheme(),
      );
}

class AppShadow {
  static List<BoxShadow> mainShadow = [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: const Color(0xFF101828).withOpacity(0.06),
    ),
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: const Color(0xFF101828).withOpacity(0.1),
    ),
  ];

  static List<BoxShadow> boxShadow = [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: const Color(0xFF101828).withOpacity(0.05),
    ),
  ];
}
