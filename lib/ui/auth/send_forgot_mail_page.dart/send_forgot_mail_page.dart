// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fun_school/repo/auth_repo/auth_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/router/pages.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../widgets/k_btn.dart';
import '../../../widgets/k_text_field.dart';

class SendForgotMailPage extends StatefulWidget {
  const SendForgotMailPage({super.key});

  @override
  State<SendForgotMailPage> createState() => _SendForgotMailPageState();
}

class _SendForgotMailPageState extends State<SendForgotMailPage> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
              "If you have forgotten your current password, you can change it in 3 easy steps. Provide your register email address then receive OTP on your email and enter it on OTP page finally input your preferred password"),
          20.height,
          KTextField(
            controller: email,
            hint: "Email Address",
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          20.height,
          KBtn(
            text: "Send",
            width: double.maxFinite,
            onClick: () {
              if (email.text.isEmpty) {
                AppUtils.showSnack("Enter Email Address");
              } else {
                AppUtils.showLoadingOverlay(() async {
                  try {
                    await AuthRepository.instance
                        .sendForgotOtp(email.text.trim());
                    appRoutes.pushNamed(
                      PagesName.emailVerificationPage,
                      extra: email.text.trim(),
                    );
                  } catch (e) {
                    AppUtils.showSnack(e.toString());
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
