// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // phone
          Align(
              alignment: Alignment(0, -.80),
              child: Container(
                color: Colors.pink,
                height: 415,
                width: 301,
              )),
          Align(
            alignment: Alignment(0, -0.1),
            child: Container(
              height: 265,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.55],
                  colors: [Colors.white.withOpacity(0), Colors.white],
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 18, left: 58, right: 58),
              child: Text(
                "Over 90% Of students who use report receiving higher marks.",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, .90),
            child: Padding(
              // padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KBtn(
                    onClick: () {
                      appRoutes.pushNamed(PagesName.signupPage);
                    },
                    text: "Sign up for free",
                    width: double.maxFinite,
                  ),
                  KBtn(
                    onClick: () {},
                    text: "Or log in",
                    width: double.maxFinite,
                    bgColor: scheme.onPrimary,
                    fbColor: scheme.primary,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
