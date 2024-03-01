class AppUrls {
  static const String domain = "https://app.citycloudschool.co.ke";
  static const String _apis = "$domain/api_docs/apis";

  // static String chatGPTKey = "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";
  static String chatGPTKey =
      "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";

  static const String helpCenter = "$domain/help.php";
  static const String about = "$domain/about.php";

  static const String registerUrl = "$_apis/register.php";
  static const String signInUrl = "$_apis/login.php";
  static const String changePassword = "$_apis/change_password.php";
  static const String forgotPassword = "$_apis/forgot_password.php";
  static const String forgotPasswordOtp = "$_apis/forgot_password_otp.php";
  static const String forgotPasswordChange =
      "$_apis/forgot_password_change.php";

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
  static const String addToFolders = "$_apis/add_course_folder_content.php";
  static const String getCourseInUserFolder =
      "$_apis/fetch_course_per_folder.php";
  static const String getMyEnrolledCoursesAndFolder =
      "$_apis/fetch_course_enrollment.php";
  static const String removeCourseFromFolder =
      "$_apis/remove_course_from_folder.php";

  static const String addStudyPlanByContent =
      "$_apis/add_study_plan_content.php";

  static const String enrollCourse = "$_apis/enroll_for_course.php";

  static const String getFlashcardByCourses =
      "$_apis/fetch_flashcard_per_course.php";
  static const String addFlashcardResult = "$_apis/add_flashcard_result.php";
  static const String getFlashcardResultByUser =
      "$_apis/fetch_flashcard_result.php";

  static const String getTips = "$_apis/fetch_tips.php";

  static const String getPowerSummary = "$_apis/fetch_power_summary.php";
  static const String getInteractiveQuiz = "$_apis/fetch_interactive_quiz.php";

  // community
  static const String getCommunityDiscussionPost =
      "$_apis/community_fetch_timelines.php";
  static const String communityPostTimelines =
      "$_apis/community_post_timelines.php";
  static const String getTrendingHashtags = "$_apis/trending_hashtags.php";
  static const String discussionLikeDislike = "$_apis/like_discussion.php";
  static const String discussionComment = "$_apis/comment_discussion.php";
  static const String getOtherProfile = "$_apis/profile.php";
  static const String getCommunityGroups = "$_apis/groups.php";
  static const String getCommunityAllGroups = "$_apis/community_all_groups.php";
  static const String followUnFollow = "$_apis/community_follow.php";
  static const String createNewGroup = "$_apis/community_add_group.php";
  static const String joinLeaveGroup = "$_apis/community_join_group.php";
  static const String groupMessages =
      "$_apis/community_chatroom_message_fetch.php";
  static const String sendGroupMessage =
      "$_apis/community_chatroom_message_add.php";
  static const String groupMemberRemove =
      "$_apis/community_chatroom_remove_member.php";
  static const String getGroupMeetings =
      "$_apis/community_chatroom_meetings_fetch.php";
  static const String createGroupMeeting =
      "$_apis/community_chatroom_meetings_add.php";

  //chat
  static const String chatUsers = "$_apis/chat_user_list.php";
  static const String allChatsByUser = "$_apis/chat_all_by_users.php";
  static const String sendMessage = "$_apis/chat_send.php";
  static const String allUsersById = "$_apis/community_user_list.php";

  // exam
  static const String getExams = "$_apis/exams.php";
  static const String getExamsByExamId = "$_apis/exams_questions.php";
  static const String saveMultiChoiceExamScore =
      "$_apis/exam_save_multichoice_result.php";
  static const String submitTheoryExam = "$_apis/exam_record_answers.php";

  //study plan
  static const String examStudyPlans = "$_apis/exam_study_plan.php";
  static const String examAddStudyPlan = "$_apis/exam_add_study_plan.php";
  static const String getExamCoursesList =
      "$_apis/exam_add_study_plan_courses.php";
}
