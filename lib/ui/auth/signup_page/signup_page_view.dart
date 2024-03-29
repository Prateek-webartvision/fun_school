// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widgets/k_btn.dart';
import '../../../widgets/k_text_field.dart';
import 'signup_page_state.dart';

class SignupPageView extends StatefulWidget {
  const SignupPageView({super.key});

  @override
  State<SignupPageView> createState() => _SignupPageViewState();
}

class _SignupPageViewState extends SignupPageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text("Welcome",
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
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
            onClick: googleLogin,
            text: "Continue with Google",
            bgColor: AppColor.white,
            fbColor: Colors.black,
            btnType: BtnType.google,
          ),
          8.height,
          KBtn(
            onClick: facebookLogin,
            text: "Continue with Facebook",
            bgColor: AppColor.facebookBlue,
            btnType: BtnType.facebook,
          ),
          8.height,
          KBtn(
            onClick: appleLogin,
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
            controller: usernameController,
            hint: "Username",
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          8.height,
          KTextField(
            controller: emailController,
            hint: "Email Address",
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          8.height,
          KTextField(
            controller: passController,
            hint: "Password",
            textInputType: TextInputType.emailAddress,
            isPassword: true,
            textInputAction: TextInputAction.next,
          ),
          8.height,
          KTextField(
            controller: pass2Controller,
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
            onClick: emailSignup,
            text: "Signup",
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
