import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/ui/study_page/controller/my_notes_controller.dart';
import 'package:fun_school/utils/app_utils.dart';

import '../../network/app_api.dart';
import '../../network/url/app_urls.dart';

class NotesRepository {
  static final _api = AppApi();

  static addNote({
    required int subjectId,
    required String contentTitle,
    required String subtitle,
    required String note,
    required String courseId,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = AppStorage.user.currentUser()!.userId!.toString();
    data['subject_id'] = subjectId.toString();
    data["title"] = contentTitle;
    data["subtitle"] = subtitle;
    data['notes'] = note;
    data['course_id'] = courseId;

    return await _api
        .postApi(AppUrls.addSubjectNotes, params: data)
        .then((value) {
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
            if (int.parse(note.userId!) ==
                AppStorage.user.currentUser()!.userId!) {
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
