// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/exam_preparation_page/exam_preparation_page.dart';
import 'package:citycloud_school/ui/profile_and_settings_page/profile_and_settings_page.dart';
import 'package:citycloud_school/ui/school_communities_page/school_communities_page.dart';
import 'package:citycloud_school/ui/study_page/study_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/email_verification_page/email_verifi_page.dart';
import '../ui/auth/signup_page/signup_page.dart';
import '../ui/auth/start_page/start_page.dart';
import '../ui/botton_nav_bar/bottom_nav_bar.dart';
import '../ui/home_page/home_page.dart';
import '../ui/splash_screen/splash_screen.dart';
import 'pages.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: PagesName.getPath(PagesName.splashScreen),

  // routs
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

        // //Login
        // GoRoute(
        //   path: PagesName.getPath(PagesName.loginPage),
        //   name: PagesName.loginPage,
        //   builder: (context, state) => LoginPage(),
        // ),
      ],
    ),

    // bottom nav page
    ShellRoute(
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: BottomNavBarPage(child: child));
        },
        routes: [
          GoRoute(
            path: PagesName.getPath(PagesName.homePage),
            name: PagesName.homePage,
            pageBuilder: (context, state) {
              return NoTransitionPage(key: state.pageKey, child: HomePage());
            },
          ),
          GoRoute(
            path: PagesName.getPath(PagesName.studyPage),
            name: PagesName.studyPage,
            pageBuilder: (context, state) {
              return NoTransitionPage(key: state.pageKey, child: StudyPage());
            },
          ),
          GoRoute(
            path: PagesName.getPath(PagesName.examPreparationPage),
            name: PagesName.examPreparationPage,
            pageBuilder: (context, state) {
              return NoTransitionPage(key: state.pageKey, child: ExamPreparationPage());
            },
          ),
          GoRoute(
            path: PagesName.getPath(PagesName.schoolCommunitiesPage),
            name: PagesName.schoolCommunitiesPage,
            pageBuilder: (context, state) {
              return NoTransitionPage(key: state.pageKey, child: SchoolCommunitiesPage());
            },
          ),
          GoRoute(
            path: PagesName.getPath(PagesName.profileAndSettings),
            name: PagesName.profileAndSettings,
            pageBuilder: (context, state) {
              return NoTransitionPage(key: state.pageKey, child: ProfileAndSettings());
            },
          ),
        ]),

    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => MaterialPage(child: HomePage()),
    ),
  ],
);
