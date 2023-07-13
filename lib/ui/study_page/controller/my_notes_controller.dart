import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/subject_notes_repo/notes_repo.dart';

class MyNotesController extends GetxController {
  List<NotesModel> _notes = [];
  List? myNotes;
  ApiState apiState = ApiState.loading;
  String? error;

  MyNotesController() {
    _initData();
  }

  _initData() async {
    await _loadData();

    // List<List<NotesModel>> temp = [];

    List temp1 = [];

    Set byCourse = _notes.map((e) => e.courseName).toSet();
    for (var courseName in byCourse) {
      final course = _notes.where((element) => element.courseName! == courseName).toList();

      List subjectList = [];

      // subject list
      Set bySubject = course.map((e) => e.subjectName).toSet();
      for (var subject in bySubject) {
        final subj = course.where((element) => element.subjectName! == subject).toList();

        List titleList = [];

        //   // title List
        Set bytitle = subj.map((e) => e.title).toSet();
        for (var title in bytitle) {
          var res = subj.where((element) => element.title! == title).toList();
          titleList.add({"title": title, "data": res});
        }

        subjectList.add({"subject": subject, "data": titleList});
      }

      temp1.add({"courseName": courseName, "data": subjectList});
    }
    print(temp1);

    myNotes = temp1;
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

// class NotFilterModel

class NotesModel {
  int? notesId;
  String? userId;
  String? username;
  String? subjectid;
  String? subjectName;
  String? courseName;
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
    courseName = json['course_name'];
    title = json['title'];
    subtitle = json['subtitle'];
    notes = json['notes'];
    addedDate = json['added_date'];
  }
}
