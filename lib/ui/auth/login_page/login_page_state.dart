import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/router/pages.dart';
import 'package:fun_school/utils/app_utils.dart';
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
      AppUtils.showLoadingOverlay(() async {
        try {
          final newUser = await AuthRepository.instance.signInWithEmailPassword(
            email: emailController.text.trim(),
            password: passController.text.trim(),
          );
          AppStorage.user.saveUser(newUser);
          appRoutes.goNamed(PagesName.homePage);
        } catch (e) {
          AppUtils.showSnack("$e");
        }
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
