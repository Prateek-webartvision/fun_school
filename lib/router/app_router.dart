// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/auth/email_verification_page.dart/email_verifi_page.dart';
import 'package:citycloud_school/ui/auth/login_page/login_page.dart';
import 'package:citycloud_school/ui/auth/signup_page/signup_page.dart';
import 'package:citycloud_school/ui/auth/start_page/start_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/home_page/home_page.dart';
import '../ui/splash_screen/splash_screen.dart';
import 'pages.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: PagesName.getPath(PagesName.splashScreen),
  
  
  routes: [
    // Splach Screen
    GoRoute(
      path: PagesName.getPath(PagesName.splashScreen),
      name: PagesName.splashScreen,
      builder: (context, state) => SplashScreen(),
    ),
    //Start page
    GoRoute(
      path: PagesName.getPath(PagesName.startPage),
      name: PagesName.startPage,
      builder: (context, state) => StartPage(),
      routes: [
        //Sign up
        GoRoute(
          path: PagesName.signupPage,
          name: PagesName.signupPage,
          builder: (context, state) => SignupPage(),
        ),
        //Email verification page
        GoRoute(
          path: PagesName.emailVerificationPage,
          name: PagesName.emailVerificationPage,
          builder: (context, state) => EmailVerificationPage(),
        ),
      ],
    ),
    //Login
    GoRoute(
      path: PagesName.getPath(PagesName.loginPage),
      name: PagesName.loginPage,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => MaterialPage(child: HomePage()),
    ),
  ],
);
