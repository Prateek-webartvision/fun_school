import 'package:fun_school/repo/auth_repo/auth_repo.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import 'signup_page_view.dart';

abstract class SignupPageState extends State<SignupPageView> {
  //  text controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final pass2Controller = TextEditingController();

  @override
  dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    pass2Controller.dispose();
    super.dispose();
  }

  googleLogin() {}
  facebookLogin() {}
  appleLogin() {}

  //email signup
  emailSignup() async {
    if (usernameController.text.isEmpty) {
      AppUtils.showSnack("Enter username");
    } else if (emailController.text.isEmpty) {
      AppUtils.showSnack("Enter Email Address");
    } else if (passController.text.isEmpty) {
      AppUtils.showSnack("Enter Password");
    } else if (pass2Controller.text.isEmpty) {
      AppUtils.showSnack("Confirm Password");
    } else if (passController.text != pass2Controller.text) {
      AppUtils.showSnack(
          "The password and confirmation password do not match.");
    } else {
      await AppUtils.showLoadingOverlay(() async {
        var res = await AuthRepository.instance
            .createAccountWithEmailPassword(
          username: usernameController.text,
          email: emailController.text.trim(),
          password: passController.text.trim(),
        )
            .onError(
          (error, stackTrace) {
            AppUtils.showSnack(error.toString());
          },
        );

        if (res != null) {
          AppUtils.showSnack(res);
          // appRoutes.goNamed(PagesName.homePage);
          appRoutes.goNamed(PagesName.loginPage);
        }
      });
    }
  }
}
