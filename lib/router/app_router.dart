// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/find_course_by_career_page/find_course_by_career_page.dart';
import 'package:citycloud_school/ui/find_course_by_interest_page/find_course_by_interest_page.dart';
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
  routerNeglect: true,
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
              path: PagesName.findCoursesBySchoolPage,
              name: PagesName.findCoursesBySchoolPage,
              pageBuilder: (context, state) => MaterialPage(child: FindCoursesBySchoolPage()),
              routes: [
                // Details page
                GoRoute(
                  parentNavigatorKey: rootNavigator,
                  path: PagesName.coursesBySchoolDetailsPage,
                  name: PagesName.coursesBySchoolDetailsPage,
                  pageBuilder: (context, state) => MaterialPage(child: SubjectDetailsPage()),
                ),
              ],
            ),

            //find course by career page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCourseByCareerPage,
              name: PagesName.findCourseByCareerPage,
              pageBuilder: (context, state) => MaterialPage(child: FindCourseByCareerPage()),
              routes: [
                //details page
                // GoRoute(
                //   parentNavigatorKey: rootNavigator,
                //   path: PagesName.courseByCareerDetailsPage,
                //   name: PagesName.courseByCareerDetailsPage,
                //   pageBuilder: (context, state) => MaterialPage(child: SubjectDetailsPage()),
                // )
              ],
            ),

            // find course by interest page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCourseByInterestPage,
              name: PagesName.findCourseByInterestPage,
              pageBuilder: (context, state) => MaterialPage(child: FindCourseByInterestPage()),
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
    //
  ],
);
