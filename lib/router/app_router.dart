// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/email_verification_page/email_verifi_page.dart';
import '../ui/auth/login_page/login_page_view.dart';
import '../ui/auth/signup_page/signup_page_view.dart';
import '../ui/auth/splash_screen/splash_screen.dart';
import '../ui/auth/start_page/start_page.dart';
import '../ui/botton_nav_bar/bottom_nav_bar.dart';
import '../ui/detail_exam_page/detail_exam_page.dart';
import '../ui/exam_preparation_page/exam_preparation_page.dart';
import '../ui/find_course_by_career_page/find_course_by_career_view.dart';
import '../ui/find_course_by_interest_page/find_course_by_interest_view.dart';
import '../ui/find_courses_by_school_page/find_courses_by_school_page_view.dart';
import '../ui/home_page/home_page.dart';
import '../ui/prepare_for_an_exam_page/prepare_for_an_exam_page.dart';
import '../ui/profile_and_settings_page/profile_and_settings_page_view.dart';
import '../ui/school_communities_page/school_communities_page.dart';
import '../ui/start_exam_pages/question_answer_page/question_answer_page.dart';
import '../ui/start_exam_pages/result_page/result_page.dart';
import '../ui/start_exam_pages/start_exam_page/start_exam_page.dart';
import '../ui/start_quiz_pages/quiz_qustion_answer_page/quiz_qustion_answer_page.dart';
import '../ui/start_quiz_pages/start_quiz_page/start_quiz_page.dart';
import '../ui/study_page/study_page.dart';
import '../ui/subject_details_page/subject_details_page.dart';
import '../ui/topic_summary_page/topic_summary_page.dart';
import 'pages.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> _shalNav = GlobalKey<NavigatorState>(debugLabel: "shell");
final GlobalKey<ScaffoldMessengerState> scaffoldMenagerKey = GlobalKey<ScaffoldMessengerState>();

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
          builder: (context, state) => SignupPageView(),
        ),

        //Email verification page
        GoRoute(
          path: PagesName.emailVerificationPage,
          name: PagesName.emailVerificationPage,
          builder: (context, state) => EmailVerificationPage(),
        ),

        //Login
        GoRoute(
          path: PagesName.loginPage,
          name: PagesName.loginPage,
          builder: (context, state) => LoginPageView(),
        ),
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
              pageBuilder: (context, state) => MaterialPage(child: FindCoursesBySchoolPageView()),
              routes: [
                // Details page
                // GoRoute(
                //   parentNavigatorKey: rootNavigator,
                //   path: PagesName.coursesBySchoolDetailsPage,
                //   name: PagesName.coursesBySchoolDetailsPage,
                //   pageBuilder: (context, state) => MaterialPage(child: SubjectDetailsPage()),
                // ),
              ],
            ),

            //find course by career page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCourseByCareerPage,
              name: PagesName.findCourseByCareerPage,
              pageBuilder: (context, state) => MaterialPage(child: FindCourseByCareerView()),
            ),

            // find course by interest page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.findCourseByInterestPage,
              name: PagesName.findCourseByInterestPage,
              pageBuilder: (context, state) => MaterialPage(child: FindCourseByInterestView()),
            ),

            // Prepare For An Exam Page
            GoRoute(
              parentNavigatorKey: rootNavigator,
              path: PagesName.prepareForAnExamPage,
              name: PagesName.prepareForAnExamPage,
              pageBuilder: (context, state) => MaterialPage(child: PrepareForAnExamPage()),
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
            return NoTransitionPage(key: state.pageKey, child: ProfileAndSettingsView());
          },
        ),
      ],
    ),

    // courses Details Page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.coursesBySchoolDetailsPage),
      name: PagesName.coursesBySchoolDetailsPage,
      pageBuilder: (context, state) => MaterialPage(child: SubjectDetailsPage()),
    ),

    // topic summary Page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.topicSummaryPage),
      name: PagesName.topicSummaryPage,
      pageBuilder: (context, state) => MaterialPage(child: TopicSummaryPage()),
    ),

    // Details exam page
    GoRoute(
        parentNavigatorKey: rootNavigator,
        path: PagesName.getPath(PagesName.detailExamPage),
        name: PagesName.detailExamPage,
        pageBuilder: (context, state) => MaterialPage(child: DetailExamPage()),
        routes: [
          //start exam Page
          GoRoute(
            parentNavigatorKey: rootNavigator,
            path: PagesName.startExamPage,
            name: PagesName.startExamPage,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: StartExamPage(),
            ),
            routes: [
              // Question answer page
              GoRoute(
                parentNavigatorKey: rootNavigator,
                path: PagesName.questionAnswerPage,
                name: PagesName.questionAnswerPage,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: QuestionAnswerPage(),
                ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: rootNavigator,
                    path: PagesName.resultPage,
                    name: PagesName.resultPage,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: ResultPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),

    // Start Quiz page
    GoRoute(
      parentNavigatorKey: rootNavigator,
      path: PagesName.getPath(PagesName.startQuizPage),
      name: PagesName.startQuizPage,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: StartQuizPage(),
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigator,
          path: PagesName.quizQustionAnswerPage,
          name: PagesName.quizQustionAnswerPage,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: QuizQustionQnswerPage(),
          ),
        )
      ],
    )
  ],
);
