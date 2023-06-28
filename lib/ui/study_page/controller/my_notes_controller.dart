import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/subject_notes_repo/notes_repo.dart';

class MyNotesController extends GetxController {
  List<NotesModel> _notes = [];
  List<List<NotesModel>>? myNotes;
  ApiState apiState = ApiState.loading;
  String? error;

  MyNotesController() {
    _initData();
  }

  _initData() async {
    await _loadData();

    Set bySubjectId = _notes.map((e) => e.subjectid).toSet();

    List<List<NotesModel>> temp = [];
    for (var ss in bySubjectId) {
      var tt = _notes.where((element) => element.subjectid!.contains(ss)).toList();
      temp.add(tt);
    }

    myNotes = temp;
    update();
  }

  _loadData() async {
    apiState = ApiState.loading;
    await NotesRepository.getAllNotes().then((value) {
      _notes = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}

class NotesModel {
  int? notesId;
  String? userId;
  String? username;
  String? subjectid;
  String? subjectName;
  String? title;
  String? subtitle;
  String? notes;
  String? addedDate;

  NotesModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    userId = json['user_id'];
    username = json['username'];
    subjectid = json['subject_id'];
    subjectName = json['subject_name'];
    title = json['title'];
    subtitle = json['subtitle'];
    notes = json['notes'];
    addedDate = json['added_date'];
  }
}
