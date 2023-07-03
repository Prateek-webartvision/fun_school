import 'package:citycloud_school/models/courses_dedails/flashcard.model.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import '../../network/app_api.dart';

class FlashCardRepository {
  static final _api = AppApi();

  static Future<List<FlashCardModel>?> getFlashCards({required int courseId}) async {
    return await _api.postApi(AppUrls.getFlashcardByCourses, params: {"course_id": courseId.toString()}).then((value) {
      if (value != null) {
        List<FlashCardModel> temp = [];
        for (var element in value) {
          FlashCardModel flashCardModel = FlashCardModel.fromJson(element);
          temp.add(flashCardModel);
        }
        return temp;
      } else {
        return null;
      }
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
      return null;
      // throw error.toString();
    });
  }

  // add flash card
  static updateFlashCardResult({required int flashCardId, required bool result}) async {
    var data = <String, String>{};
    data["user_id"] = AppStorage.user.currentUser()!.userid!.toString();
    data["flashcard_id"] = flashCardId.toString();
    data["flashcard_result"] = result.toString();

    await _api.postApi(AppUrls.addFlashcardResult, params: data).then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
