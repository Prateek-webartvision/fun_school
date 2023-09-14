import 'package:citycloud_school/models/courses_dedails/flashcard.model.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/foundation.dart';

import '../../network/app_api.dart';

class FlashCardRepository {
  static final _api = AppApi();

  static Future<List<FlashCardModel>?> getFlashCards({required int courseId}) async {
    return await _api.postApi(AppUrls.getFlashcardByCourses, params: {"course_id": courseId.toString()}).then((value) async {
      if (value != null) {
        var res = await _getFlashcardResultbyUser();

        List<FlashCardModel> temp = [];
        for (var element in value) {
          FlashCardModel flashCardModel = FlashCardModel.fromJson(element);

          for (var e1 in res) {
            if (flashCardModel.flashcardId.toString() == e1["flashcard_id"]) {
              flashCardModel.copyWith(flashcardResult: (e1["flashcard_id"] != null) ? bool.parse(e1["flashcard_result"].toString()) : null);
            }
          }

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
      debugPrint(value);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  static _getFlashcardResultbyUser() async {
    return await _api.postApi(AppUrls.getFlashcardResultByUser, params: {"user_id": AppStorage.user.currentUser()!.userid!.toString()}).then((value) {
      return value;
    }).onError((error, stackTrace) {
      debugPrint("dasda");
    });
  }
}
