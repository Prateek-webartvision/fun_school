import 'package:citycloud_school/network/url/app_urls.dart';

import '../../network/app_api.dart';

class QuizRepository {
  static final _api = AppApi();

  Future getQuiz({required String subjectId}) async {
    print(AppUrls.getQuizs);
  }
}
