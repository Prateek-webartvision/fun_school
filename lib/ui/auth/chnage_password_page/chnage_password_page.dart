// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fun_school/repo/auth_repo/auth_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../widgets/k_btn.dart';
import '../../../widgets/k_text_field.dart';

class ForgotChangePasswordPage extends StatefulWidget {
  const ForgotChangePasswordPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<ForgotChangePasswordPage> createState() =>
      _ForgotChangePasswordPageState();
}

class _ForgotChangePasswordPageState extends State<ForgotChangePasswordPage> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          20.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                KTextField(
                  controller: newPassword,
                  hint: "New Password",
                ),
                10.height,
                KTextField(
                  controller: conformPassword,
                  hint: "Confirm Password",
                ),
                40.height,
                KBtn(
                  height: 44,
                  width: double.maxFinite,
                  onClick: () {
                    if (newPassword.text.isEmpty ||
                        conformPassword.text.isEmpty) {
                      AppUtils.showSnack("Enter Password");
                    } else if (newPassword.text.trim() !=
                        conformPassword.text.trim()) {
                      AppUtils.showSnack("Password dos't match");
                    } else {
                      // Change password
                      AppUtils.showLoadingOverlay(() async {
                        try {
                          await AuthRepository.instance.changeForgotPassword(
                              widget.email,
                              newPassword.text.trim(),
                              conformPassword.text.trim());
                          appRoutes.pop();
                          appRoutes.pop();
                          appRoutes.pop();
                        } catch (e) {
                          AppUtils.showSnack(e.toString());
                        }
                      });
                    }
                  },
                  text: "update".toUpperCase(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
