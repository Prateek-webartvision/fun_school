// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/router/pages.dart';
import 'package:get/utils.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widgets/k_btn.dart';
import '../../../widgets/k_text_field.dart';
import 'login_page_state.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends LoginPageSate {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text("Welcome",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            "Quickly sign in with",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          12.height,
          KBtn(
            text: "Continue with Google",
            bgColor: AppColor.white,
            fbColor: Colors.black,
            btnType: BtnType.google,
            onClick: googleLogin,
          ),
          8.height,
          KBtn(
            text: "Continue with Facebook",
            bgColor: AppColor.facebookBlue,
            btnType: BtnType.facebook,
            onClick: facebookLogin,
          ),
          8.height,
          KBtn(
            text: "Continue with Apple",
            bgColor: AppColor.white,
            fbColor: Colors.black,
            btnType: BtnType.apple,
            onClick: appleLogin,
          ),
          12.height,
          Text(
            "Or sign in with email",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          12.height,
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
          10.height,
          Align(
            alignment: Alignment.centerRight,
            child: Text.rich(
              TextSpan(
                text: "Forgot",
                children: [
                  TextSpan(text: " "),
                  TextSpan(
                    text: "Password!",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        appRoutes.pushNamed(PagesName.sendForgotMailPage);
                      },
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.theme.primaryColor,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // color: Colors.pink,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: KBtn(
            // onClick: emailSignup,
            text: "Signin",
            width: double.maxFinite,
            onClick: loginWithEmail,
          ),
        ),
      ),
    );
  }
}
