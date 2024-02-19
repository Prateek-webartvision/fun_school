// ignore_for_file: prefer_const_constructors

import 'package:fun_school/models/user/user.model.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/router/pages.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:fun_school/widgets/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../repo/auth_repo/auth_repo.dart';
import '../../style/color.dart';
import 'profile_and_settings_page_view.dart';

abstract class ProfileAndSettingsState extends State<ProfileAndSettingsView> {
  // current user
  UserModel? currentUser = AppStorage.user.currentUser();

  //logout user
  logOut() {
    AppUtils.showLoadingOverlay(
      () async {
        AppStorage.user.removeUser();
        await Future.delayed(const Duration(seconds: 2));
        appRoutes.goNamed(PagesName.startPage);
      },
    );
  }

  // change password click
  changePassword() async {
    // Scaffold.of(context).
    rootNavigator.currentState!.push(MaterialPageRoute(
      builder: (context) {
        return ChangePasswordPage();
      },
    ));
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordText = TextEditingController();
  TextEditingController newPasswordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColor.scaffoldBg,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                        onTap: () {
                          AppUtils.closeBottomSheet();
                        },
                        child: SizedBox(height: 48, child: Icon(Icons.close))),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  KTextField(
                    hint: "Old Password",
                    controller: oldPasswordText,
                  ),
                  10.height,
                  KTextField(
                    hint: "New Password",
                    controller: newPasswordText,
                  ),
                  10.height,
                  KTextField(
                    hint: "Confirm Password",
                    controller: confirmPasswordText,
                  ),
                  40.height,
                  KBtn(
                    height: 44,
                    width: double.maxFinite,
                    onClick: () {
                      if (oldPasswordText.text.isEmpty ||
                          newPasswordText.text.isEmpty ||
                          confirmPasswordText.text.isEmpty) {
                        AppUtils.showSnack("Enter all Fields");
                      } else {
                        rootNavigator.currentState!.focusNode.unfocus();
                        AppUtils.showLoadingOverlay(() async {
                          await AuthRepository.instance.changePassword(
                            oldPassword: oldPasswordText.text.trim(),
                            newPassword: newPasswordText.text.trim(),
                            conformNewPassword: confirmPasswordText.text.trim(),
                          );
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
      ),
    );
  }
}
