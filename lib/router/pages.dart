class PagesName {
  static String splashScreen = "SplashScreen";
  static String startPage = "StartPage";
  static String loginPage = "LoginPage";
  static String signUpPage = "SignUpPage";
  static String emailVerificationPage = "EmailVerificationPage";
  static String sendForgotMailPage = "SendForgotMailPage";
  static String forgetChangePasswordPage = "ForgetChangePasswordPage";

  static String bottomNavBarPage = "BottomNavBarPage";
  static String homePage = "homePage";
  static String studyPage = "StudyPage";
  static String examPreparationPage = "ExamPreparationPage";
  static String schoolCommunitiesPage = "SchoolCommunitiesPage";
  static String profileAndSettings = "ProfileAndSettings";

  static String findCoursesBySchoolPage = "FindCoursesBySchoolPage";
  static String findCourseByCareerPage = "FindCourseByCareerPage";
  static String findCourseByInterestPage = "FindCourseByInterestPage";

  static String subjectDetailsPage = "SubjectDetailsPage";

  //
  static String prepareForAnExamPage = "PrepareForAnExamPage";

  static String topicSummaryPage = "topicSummaryPage";
  static String detailExamPage = "detailExamPage";
  // static String startExamPage = "startExamPage";
  static String questionAnswerPage = "QuestionAnswerPage";
  static String resultPage = "resultPage";

  static String startQuizPage = "startQuizPage";
  static String quizQuestionAnswerPage = "quizQuestionAnswerPage";
  static String quizResultPage = "quizResultPage";

  static String chatGptPage = "chatGptPage";

  static getPath(String v) {
    return "/${v.toLowerCase()}";
  }
}
