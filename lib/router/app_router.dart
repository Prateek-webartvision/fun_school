// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/courses_details/courses.model.dart';
import '../ui/auth/chnage_password_page/chnage_password_page.dart';
import '../ui/auth/email_verification_page/email_verifi_page.dart';
import '../ui/auth/login_page/login_page_view.dart';
import '../ui/auth/send_forgot_mail_page.dart/send_forgot_mail_page.dart';
import '../ui/auth/signup_page/signup_page_view.dart';
import '../ui/auth/splash_screen/splash_screen.dart';
import '../ui/auth/start_page/start_page.dart';
import '../ui/botton_nav_bar/bottom_nav_bar.dart';
import '../ui/chat_gpt_page/chat_gpt_page.dart';
import '../ui/detail_exam_page/detail_exam_page.dart';
import '../ui/exam_preparation_page/exam_preparation_page.dart';
import '../ui/find_course_by_career_page/find_course_by_career_view.dart';
import '../ui/find_course_by_interest_page/find_course_by_interest_view.dart';
import '../ui/find_courses_by_school_page/find_courses_by_school_page_view.dart';
import '../ui/home_page/home_page.dart';
import '../ui/prepare_for_an_exam_page/prepare_for_an_exam_page.dart';
import '../ui/profile_and_settings_page/profile_and_settings_page_view.dart';
import '../ui/school_communities_page/school_communities_page.dart';
import '../ui/exam_certificate_start_pages/result_page/result_page.dart';
import '../ui/start_quiz_pages/quiz_qustion_answer_page/quiz_qustion_answer_page.dart';
import '../ui/start_quiz_pages/quiz_result_page/result_page/quiz_result_page.dart';
import '../ui/start_quiz_pages/start_quiz_view.dart';
import '../ui/study_page/study_page.dart';
import '../ui/subject_details_page/subject_details_view.dart';
import 'pages.dart';

final GlobalKey<NavigatorState> rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> _shallNav =
    GlobalKey<NavigatorState>(debugLabel: "shell");
final GlobalKey<ScaffoldMessengerState> scaffoldManagerKey =
    GlobalKey<ScaffoldMessengerState>();

final GoRouter appRoutes = GoRouter(
  initialLocation: PagesName.getPath(PagesName.splashScreen),

  navigatorKey: rootNavigator,
  routerNeglect: true,

  //* routs
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.splashScreen),
      name: PagesName.splashScreen,
      builder: (context, state) => SplashScreen(),
    ),

    //* Start page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.startPage),
      name: PagesName.startPage,
      builder: (context, state) => StartPage(),
      routes: [
        //* Sign up
        GoRoute(
          path: PagesName.signUpPage,
          name: PagesName.signUpPage,
          builder: (context, state) => SignupPageView(),
        ),

        //* Login
        GoRoute(
          path: PagesName.loginPage,
          name: PagesName.loginPage,
          builder: (context, state) => LoginPageView(),
        ),
      ],
    ),

    //* Send forgot mail
    GoRoute(
      path: PagesName.getPath(PagesName.sendForgotMailPage),
      name: PagesName.sendForgotMailPage,
      builder: (context, state) => SendForgotMailPage(),
    ),

    //* Email verification page
    GoRoute(
      path: PagesName.getPath(PagesName.emailVerificationPage),
      name: PagesName.emailVerificationPage,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: EmailVerificationPage(email: state.extra as String),
        );
      },
    ),
    //* Email verification page
    GoRoute(
      path: PagesName.getPath(PagesName.forgetChangePasswordPage),
      name: PagesName.forgetChangePasswordPage,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: ForgotChangePasswordPage(email: state.extra as String),
        );
      },
    ),

    //* bottom nav page
    ShellRoute(
      navigatorKey: _shallNav,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: BottomNavBarPage(child: child),
        );
      },
      routes: [
        //* home page
        GoRoute(
          parentNavigatorKey: _shallNav,
          path: PagesName.getPath(PagesName.homePage),
          name: PagesName.homePage,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: HomePage());
          },
          routes: [
            //* find courses by school page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCoursesBySchoolPage,
              name: PagesName.findCoursesBySchoolPage,
              pageBuilder: (context, state) =>
                  MaterialPage(child: FindCoursesBySchoolPageView()),
            ),

            //* find course by career page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCourseByCareerPage,
              name: PagesName.findCourseByCareerPage,
              pageBuilder: (context, state) =>
                  MaterialPage(child: FindCourseByCareerView()),
            ),

            //* find course by interest page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCourseByInterestPage,
              name: PagesName.findCourseByInterestPage,
              pageBuilder: (context, state) =>
                  MaterialPage(child: FindCourseByInterestView()),
            ),

            //* Prepare For An Exam Page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.prepareForAnExamPage,
              name: PagesName.prepareForAnExamPage,
              pageBuilder: (context, state) =>
                  MaterialPage(child: PrepareForAnExamPage()),
            ),
          ],
        ),

        //* study page
        GoRoute(
          parentNavigatorKey: _shallNav,
          path: PagesName.getPath(PagesName.studyPage),
          name: PagesName.studyPage,
          pageBuilder: (context, state) {
            return NoTransitionPage(key: state.pageKey, child: StudyPage());
          },
        ),

        //* exam preparation page
        GoRoute(
          parentNavigatorKey: _shallNav,
          path: PagesName.getPath(PagesName.examPreparationPage),
          name: PagesName.examPreparationPage,
          pageBuilder: (context, state) {
            return NoTransitionPage(
                key: state.pageKey, child: ExamPreparationPage());
          },
        ),
        //* school Communities Page
        GoRoute(
          parentNavigatorKey: _shallNav,
          path: PagesName.getPath(PagesName.schoolCommunitiesPage),
          name: PagesName.schoolCommunitiesPage,
          pageBuilder: (context, state) {
            return NoTransitionPage(
                key: state.pageKey, child: SchoolCommunitiesPage());
          },
        ),
        //* profile And Settings
        GoRoute(
          parentNavigatorKey: _shallNav,
          path: PagesName.getPath(PagesName.profileAndSettings),
          name: PagesName.profileAndSettings,
          pageBuilder: (context, state) {
            return NoTransitionPage(
                key: state.pageKey, child: ProfileAndSettingsView());
          },
        ),
      ],
    ),

    //* courses Details Page
    GoRoute(
        parentNavigatorKey: rootNavigator,
        path: PagesName.getPath(PagesName.subjectDetailsPage),
        name: PagesName.subjectDetailsPage,
        pageBuilder: (context, state) {
          CoursesModel? obj = state.extra as CoursesModel?;
          return MaterialPage(child: SubjectDetailsView(courseData: obj));
        }),

    //* Details exam page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.detailExamPage),
      name: PagesName.detailExamPage,
      pageBuilder: (context, state) => MaterialPage(
        child: DetailCertificateExamPage(),
        name: state.name,
        arguments: state.extra,
      ),
    ),

    //* result page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.resultPage),
      name: PagesName.resultPage,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ResultPage(),
      ),
    ),

    //* Start Quiz page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.startQuizPage),
      name: PagesName.startQuizPage,
      pageBuilder: (context, state) {
        Map data = state.extra as Map;
        return MaterialPage(
          key: state.pageKey,
          child: StartQuizView(
            title: state.uri.queryParameters['title'],
            subjectId: int.parse(data['subjectId'].toString()),
            courseId: data['courseId'].toString(),
          ),
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigator,
          path: PagesName.quizQuestionAnswerPage,
          name: PagesName.quizQuestionAnswerPage,
          pageBuilder: (context, state) {
            Map data = state.extra as Map;
            return MaterialPage(
              key: state.pageKey,
              child: QuizQustionQnswerPage(
                extraController: data['controller'],
                subjectId: data["subjectId"],
                courseId: data['courseId'],
              ),
            );
          },
        ),

        //* quiz result page
        GoRoute(
          parentNavigatorKey: rootNavigator,
          path: PagesName.quizResultPage,
          name: PagesName.quizResultPage,
          pageBuilder: (context, state) {
            Map data = state.extra as Map;

            return MaterialPage(
              key: state.pageKey,
              child: QuizResultPage(
                quizWithAns: data['data'],
                type: data["type"],
                subjectId: data['subjectId'],
                courseId: data["courseId"],
              ),
            );
          },
        ),
      ],
    ),

    //* chat Gpt
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.chatGptPage),
      name: PagesName.chatGptPage,
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: ChatGptPage()),
    )
  ],
);
