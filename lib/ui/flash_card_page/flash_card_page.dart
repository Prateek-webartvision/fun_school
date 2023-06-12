// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class FlashCardPage extends StatelessWidget {
  const FlashCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () => appRoutes.pop(),
          child: Icon(Icons.close),
        ),
        title: Text("1/3", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          Icon(Icons.settings_outlined),
          16.width,
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: AppColor.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFA500).withOpacity(0.1),
                    border: Border.all(color: Color(0xFFFFA500)),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFA500),
                    ),
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Color(0xFF008000).withOpacity(0.1),
                    border: Border.all(color: Color(0xFF008000)),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "2",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF008000),
                    ),
                  ),
                )
              ],
            ),
          ),
          24.height,

          //Flip card
          Container(
            height: 532,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColor.softBorderColor,
                  offset: Offset(2, 4),
                  blurRadius: 2,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.volume_up_rounded),
                ),
                Align(
                  alignment: Alignment(0, -0.7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/img/study.jpg",
                      height: 200,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 232,
                    width: double.maxFinite,
                    // color: Colors.green,
                    child: Text(
                      "Algebra (from Arabic الجبر (al-jabr) 'reunion of broken parts,[1] bonesetting'[2]) is the study of variables and the rules for manipulating these variables in formulas;[3] it is a unifying thread of almost all of mathematics.[4] Elementary algebra deals with the manipulation of variables (commonly represented by Roman letters) as if they were numbers and is therefore essential in all applications of mathematics. Abstract algebra is the name given, mostly in education, to the study of algebraic structures such as groups, rings, and fields. Linear algebra, which deals with linear equations and linear mappings, is used for modern presentations of geometry, and has many practical applications (in weather forecasting, for example). There are many areas of mathematics that belong to algebra, some having \"algebra\" in their name, such as commutative algebra, and some not, such as Galois theory.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                      maxLines: 10,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Tap the card to flip it",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.85, 0),
              child: Icon(Icons.play_circle_fill_rounded),
            )
          ],
        ),
      ),
    );
  }
}
