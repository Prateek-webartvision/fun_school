// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeoutAnimation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    fadeoutAnimation = Tween<double>(begin: 0, end: 1).animate(animationController);

    animationController.forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        appRoutes.goNamed(PagesName.startPage);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: FadeTransition(
          opacity: fadeoutAnimation,
          child: Image.asset(
            AppAssets.logo,
            height: 160,
            width: 160,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
