import 'package:citycloud_school/network/app_api.dart';
import 'package:citycloud_school/network/api/app_urls.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppApi()
        .postApi(
          AppUrls.registerUrl,
          params: {
            "username": "kundan",
            "email": "kd",
            "password": "password",
          },
        )
        .then((value) => print(value))
        .onError(
          (error, stackTrace) => print("error ${error.toString()}"),
        );
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMenagerKey,
      title: 'Fun School',
      theme: AppTheme.light,
      routerConfig: appRoutes,
    );
  }
}
