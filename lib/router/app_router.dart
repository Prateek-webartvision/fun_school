// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/email_verification_page/email_verifi_page.dart';
import '../ui/auth/signup_page/signup_page.dart';
import '../ui/auth/splash_screen/splash_screen.dart';
import '../ui/auth/start_page/start_page.dart';
import '../ui/botton_nav_bar/bottom_nav_bar.dart';
import '../ui/exam_preparation_page/exam_preparation_page.dart';
import '../ui/find_courses_by_school_page/find_courses_by_school_page.dart';
import '../ui/home_page/home_page.dart';
import '../ui/profile_and_settings_page/profile_and_settings_page.dart';
import '../ui/school_communities_page/school_communities_page.dart';
import '../ui/study_page/study_page.dart';
import '../ui/subject_details_page/subject_details_page.dart';
import 'pages.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> _shalNav = GlobalKey<NavigatorState>(debugLabel: "shell");

final GoRouter appRoutes = GoRouter(
  initialLocation: PagesName.getPath(PagesName.splashScreen),
  navigatorKey: rootNavigator,
  // routs
  routes: [
    // Splach Screen
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.splashScreen),
      name: PagesName.splashScreen,
      builder: (context, state) => SplashScreen(),
    ),

    //Start page
    GoRoute(
      parentNavigatorKey: rootNavigator,
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
      navigatorKey: _shalNav,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: BottomNavBarPage(child: child),
        );
      },
      routes: [
        // home page
        GoRoute(
          parentNavigatorKey: _shalNav,
          path: PagesName.getPath(PagesName.homePage),
          name: PagesName.homePage,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: HomePage());
          },
          routes: [
            // find courses by school page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCoursesBySchool,
              name: PagesName.findCoursesBySchool,
              pageBuilder: (context, state) => MaterialPage(child: FindCoursesBySchool()),
              routes: [
                //details page
                _subjectPage,
              ],
            ),
          ],
        ),

        // study page
        GoRoute(
          parentNavigatorKey: _shalNav,
          path: PagesName.getPath(PagesName.studyPage),
          name: PagesName.studyPage,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: StudyPage());
          },
        ),

        // exam preparation page
        GoRoute(
          parentNavigatorKey: _shalNav,
          path: PagesName.getPath(PagesName.examPreparationPage),
          name: PagesName.examPreparationPage,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: ExamPreparationPage());
          },
        ),
        // school Communities Page
        GoRoute(
          parentNavigatorKey: _shalNav,
          path: PagesName.getPath(PagesName.schoolCommunitiesPage),
          name: PagesName.schoolCommunitiesPage,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: SchoolCommunitiesPage());
          },
        ),
        // profile And Settings
        GoRoute(
          parentNavigatorKey: _shalNav,
          path: PagesName.getPath(PagesName.profileAndSettings),
          name: PagesName.profileAndSettings,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: ProfileAndSettings());
          },
        ),
      ],
    ),
  ],
);

// subject details page
GoRoute get _subjectPage => GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.subjectDetailsPage,
      name: PagesName.subjectDetailsPage,
      pageBuilder: (context, state) => MaterialPage(child: SubjectDetailsPage()),
    );
