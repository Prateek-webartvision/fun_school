import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/ui/study_page/controller/my_notes_controller.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import '../../network/app_api.dart';
import '../../network/url/app_urls.dart';

class NotesRepository {
  static final _api = AppApi();

  static addNote({
    required String noteTitle,
    required int subjectId,
    required String contentTitle,
    required String subtitle,
    required String note,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = AppStorage.user.currentUser()!.userid!.toString();
    data['subject_id'] = subjectId.toString();
    data["title"] = contentTitle;
    data["subtitle"] = subtitle;
    data['notes'] = note;

    return await _api.postApi(AppUrls.addSubjectNotes, params: data).then((value) {
      if (value["code"] == 200) {
        return value['message'];
      } else {
        AppUtils.showSnack(value['message']);
      }
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }

  // get notes
  static Future<List<NotesModel>> getAllNotes() async {
    return await _api.getApi(AppUrls.getAllNotes).then((value) {
      List<NotesModel> myNotes = [];

      if (value != null) {
        for (var element in value) {
          final note = NotesModel.fromJson(element);
          if (note.userId != null) {
            if (int.parse(note.userId!) == AppStorage.user.currentUser()!.userid!) {
              myNotes.add(note);
            }
          }
        }
      }
      return myNotes;
    }).onError((error, stackTrace) {
      // AppUtils.showSnack(error.toString());
      throw error.toString();
    });
  }
}
