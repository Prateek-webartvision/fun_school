class AppUrls {
  static const String domain = "https://app.citycloudschool.co.ke";
  static const String _apis = "$domain/api_docs/apis";

  // static String chatGPTKey = "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";
  static String chatGPTKey = "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";

  static const String helpCenter = "$domain/help.php";
  static const String about = "$domain/about.php";

  static const String registerUrl = "$_apis/register.php";
  static const String signInUrl = "$_apis/login.php";
  static const String changePassword = "$_apis/change_password.php";

  static const String coursesAndDetailsUrl = "$_apis/course_details.php";

  static const String addSubjectNotes = "$_apis/add_subject_notes.php";
  static const String getAllNotes = "$_apis/fetch_subject_notes.php";

  static const String getQuizs = "$_apis/fetch_quiz.php";
  static const String addQuizScore = "$_apis/add_quiz_score.php";
  static const String fetchQuizScore = "$_apis/fetch_quiz_score.php";

  static const String addStudyPlan = "$_apis/add_study_plan.php";
  static const String getStudyPlans = "$_apis/fetch_study_plan.php";

  static const String createFolder = "$_apis/add_course_folder.php";
  static const String myCourseFolders = "$_apis/fetch_course_folder.php";

  static const String addStudyPlanByContent = "$_apis/add_study_plan_content.php";

  static const String enrollCourse = "$_apis/enroll_for_course.php";

  static const String getFlashcardByCourses = "$_apis/fetch_flashcard_per_course.php";
  static const String addFlashcardResult = "$_apis/add_flashcard_result.php";
  static const String getFlashcardResultByUser = "$_apis/fetch_flashcard_result.php";

  static const String getTips = "$_apis/fetch_tips.php";

  static const String getPaworSummary = "$_apis/fetch_power_summary.php";
  static const String getInteractiveQuiz = "$_apis/fetch_interactive_quiz.php";
}
