import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';

import 'profile_and_settings_page.dart';

abstract class ProfileAndSettingsState extends State<ProfileAndSettingsView> {
  //logout user
  logOut() {
    AppUtils.showloadingOverlay(
      () async {
        AppStorage.user.removeUser();
        await Future.delayed(const Duration(seconds: 2));
        appRoutes.goNamed(PagesName.startPage);
      },
    );
  }
}
