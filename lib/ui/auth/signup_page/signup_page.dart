// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';
import '../../../widegts/k_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            "Quickly sign up with",
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          12.height,
          KBtn(
            onClick: () {},
            text: "Continue with Google",
            bgColor: AppColor.white,
            fbColor: Colors.black,
            btnType: BtnType.google,
          ),
          8.height,
          KBtn(
            onClick: () {},
            text: "Continue with Facebook",
            bgColor: AppColor.facebookBlue,
            btnType: BtnType.facebook,
          ),
          8.height,
          KBtn(
            onClick: () {},
            text: "Continue with Apple",
            bgColor: AppColor.white,
            fbColor: Colors.black,
            btnType: BtnType.apple,
          ),
          12.height,
          Text(
            "Or create an account",
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          12.height,
          KTextField(
            hint: "Username",
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          8.height,
          KTextField(
            hint: "Email Address",
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          8.height,
          KTextField(
            hint: "Password",
            textInputType: TextInputType.emailAddress,
            isPassword: true,
            textInputAction: TextInputAction.next,
          ),
          8.height,
          KTextField(
            hint: "Confirm Password",
            textInputType: TextInputType.emailAddress,
            isPassword: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // color: Colors.pink,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: KBtn(
            onClick: () {
              // appRoutes.pushNamed(PagesName.emailVerificationPage, extra: "abc@email.com");
              appRoutes.goNamed(PagesName.homePage);
            },
            text: "Next",
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
