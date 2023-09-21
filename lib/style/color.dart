import 'package:flutter/material.dart';

import 'dart:math' as math;

class AppColor {
  // static const Color mainColor = Color(0xff6938EF);
  static const Color mainColor = Color(0xff1D3460);
  // static const Color pinkColor = Color(0xffF670C7);
  static const Color pinkColor = Color(0xff999999);
  static const Color scaffoldBg = Color(0xffF4F4F4);
  static const Color darkScaffoldBg = Color(0xff1F3265);
  static const Color white = Colors.white;

  static const Color facebookBlue = Color(0xff1877F2);
  static const Color darkTextColor = Color(0xff192325);
  static const Color tegTextColor = Color(0xff001A3A);
  static const Color textFeildBorderColor = Color(0xffD0D4D9);
  static const Color softBorderColor = Color(0xffdedede);
  static const Color unSelectedTapColor = Color(0xff656565);
  static const Color lightTextColor = Color(0xff999999);
  static const Color yellow = Color(0xffFFA500);
  static const Color green = Color(0xff008000);
  static const Color red = Color(0xffFF0000);

  //random colors
  static Color get randomColor => Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
