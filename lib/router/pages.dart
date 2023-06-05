class PagesName {
  static String splashScreen = "SplashScreen";
  static String startPage = "StartPage";
  static String loginPage = "LoginPage";
  static String signupPage = "SignupPage";
  static String emailVerificationPage = "EmailVerificationPage";
  static String bottomNavBarPage = "BottomNavBarPage";
  static String homePage = "homePage";
  static String studyPage = "StudyPage";
  static String examPreparationPage = "ExamPreparationPage";
  static String schoolCommunitiesPage = "SchoolCommunitiesPage";
  static String profileAndSettings = "ProfileAndSettings";

  static getPath(String v) {
    return "/${v.toLowerCase()}";
  }
}
