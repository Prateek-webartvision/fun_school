class PagesName {
  static String splashScreen = "SplashScreen";
  static String startPage = "StartPage";
  static String loginPage = "LoginPage";
  static String signupPage = "SignupPage";
  static String emailVerificationPage = "EmailVerificationPage";

  static getPath(String v) {
    return "/${v.toLowerCase()}";
  }
}
