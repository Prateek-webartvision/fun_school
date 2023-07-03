class AppUrls {
  static const String domain = "https://app.citycloudschool.co.ke";
  static const String _apis = "$domain/api_docs/apis";

  static const String registerUrl = "$_apis/register.php";
  static const String signInUrl = "$_apis/login.php";
  static const String changePassword = "$_apis/change_password.php";

  static const String coursesAndDetailsUrl = "$_apis/course_details.php";

  static const String addSubjectNotes = "$_apis/add_subject_notes.php";
  static const String getAllNotes = "$_apis/fetch_subject_notes.php";

  static const String getQuizs = "$_apis/fetch_quiz.php";

  static const String addStudyPlan = "$_apis/add_study_plan.php";
  static const String getStudyPlans = "$_apis/fetch_study_plan.php";

  static const String addStudyPlanByContent = "$_apis/add_study_plan_content.php";

  static const String enrollCourse = "$_apis/enroll_for_course.php";

  static const String getFlashcardByCourses = "$_apis/fetch_flashcard_per_course.php";
  static const String addFlashcardResult = "$_apis/add_flashcard_result.php";
}
