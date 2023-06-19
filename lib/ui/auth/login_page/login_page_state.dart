import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../repo/auth_repo/auth_repo.dart';
import 'login_page_view.dart';

abstract class LoginPageSate extends State<LoginPageView> {
  // text controllers
  final emailController = TextEditingController();
  final passController = TextEditingController();

  googleLogin() {}
  facebookLogin() {}
  appleLogin() {}

  // login with email
  loginWithEmail() {
    if (emailController.text.isEmpty) {
      AppUtils.showSnack("Enter email");
    } else if (passController.text.isEmpty) {
      AppUtils.showSnack("Enter password");
    } else {
      AppUtils.showloadingOverlay(() async {
        await AuthRepository.instance.signInWithEmailPassword(email: emailController.text, password: passController.text).then((value) {
          /// add user to local storage
          AppStorage.user.saveUser(value);
          //  naovigate to home page
          appRoutes.goNamed(PagesName.homePage);
        }).onError((error, stackTrace) {
          AppUtils.showSnack("$error");
        });
      });
    }
  }

  @override
  dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
