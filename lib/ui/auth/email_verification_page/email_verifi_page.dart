// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/auth_repo/auth_repo.dart';
import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import '../../../utils/app_utils.dart';
import '../../../widgets/k_btn.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key, required this.email});
  final String email;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log(widget.email.toString(), name: "Email page");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Verify OTP",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          4.height,
          Text(
            "Enter OTP received on ${widget.email}",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          30.height,
          OTPView(
            controller: otp,
            style: OTPStyle(),
            otpCount: 4,
            onSubmit: (otpT) {
              otp.text = otpT;
            },
          ),
          20.height,
          KBtn(
            text: "Verify",
            width: double.maxFinite,
            onClick: () {
              if (otp.text.isEmpty && otp.text.length != 4) {
                AppUtils.showSnack("Enter OTP");
              } else {
                AppUtils.showLoadingOverlay(() async {
                  try {
                    await AuthRepository.instance
                        .verifyOtp(widget.email, otp.text.trim());
                    //* new password page
                    appRoutes.pushNamed(PagesName.forgetChangePasswordPage,
                        extra: widget.email);
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
}
