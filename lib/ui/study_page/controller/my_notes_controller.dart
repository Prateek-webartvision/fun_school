import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/subject_notes_repo/notes_repo.dart';

class MyNotesController extends GetxController {
  List<NotesModel> _notes = [];
  List<NestedNoteByCourse>? myNotes;
  ApiState apiState = ApiState.loading;
  String? error;

  MyNotesController() {
    _initData();
  }

  _initData() async {
    await _loadData();

    List<NestedNoteByCourse> temp1 = [];

    Set byCourse = _notes.map((e) => e.courseName).toSet();
    for (var courseName in byCourse) {
      final course =
          _notes.where((element) => element.courseName! == courseName).toList();

      List<NotesBySubject> subjectList = [];

      Set bySubject = course.map((e) => e.subjectName).toSet();
      for (var subject in bySubject) {
        final subj =
            course.where((element) => element.subjectName! == subject).toList();

        List<NoteByTitle> titleList = [];

        Set byTitle = subj.map((e) => e.title).toSet();
        for (var title in byTitle) {
          final res = subj.where((element) => element.title! == title).toList();

          Set bySubTitle = res.map((e) => e.subtitle).toSet();

          List<NoteBySubTitle> subTitleList = [];
          for (var subtitle in bySubTitle) {
            final note = res.where((ee) => ee.subtitle! == subtitle).toList();

            subTitleList.add(NoteBySubTitle(
                data: note, subTitle: subtitle, isSubTitleVisible: false));
          }
          // titleList.add({"title": title, "data": res});

          titleList.add(NoteByTitle(
              title: title, isTitleVisible: false, data: subTitleList));
        }

        subjectList.add(NotesBySubject(
          subjectName: subject,
          isChaptersVisible: false,
          data: titleList,
        ));
      }

      final notesByCourse = NestedNoteByCourse(
        courseName: courseName,
        data: subjectList,
        totalNotes: course.length,
        isCourseVisible: false,
      );
      temp1.add(notesByCourse);
    }
    myNotes = temp1;
    update();
  }

  coursetVisiblity({required NestedNoteByCourse item}) {
    item.isCourseVisible = !item.isCourseVisible;
    update();
  }

  subjectVisiblity({required NotesBySubject item}) {
    item.isChaptersVisible = !item.isChaptersVisible;
    update();
  }

  titleVisiblity({required NoteByTitle item}) {
    item.isTitleVisible = !item.isTitleVisible;
    update();
  }

  subTitleVisiblity({required NoteBySubTitle item}) {
    item.isSubTitleVisible = !item.isSubTitleVisible;
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

class NestedNoteByCourse {
  String courseName;
  List<NotesBySubject> data;
  int totalNotes;
  bool isCourseVisible;

  NestedNoteByCourse(
      {required this.courseName,
      required this.data,
      required this.totalNotes,
      required this.isCourseVisible});
}

class NotesBySubject {
  String subjectName;
  bool isChaptersVisible;
  List<NoteByTitle> data;

  NotesBySubject(
      {required this.subjectName,
      required this.isChaptersVisible,
      required this.data});
}

class NoteByTitle {
  String title;
  bool isTitleVisible;
  List<NoteBySubTitle> data;

  NoteByTitle(
      {required this.data, required this.title, required this.isTitleVisible});
}

class NoteBySubTitle {
  String subTitle;
  bool isSubTitleVisible;
  List<NotesModel> data;

  NoteBySubTitle(
      {required this.data,
      required this.subTitle,
      required this.isSubTitleVisible});
}

class NotesModel {
  int? notesId;
  String? userId;
  String? username;
  String? subjectId;
  String? subjectName;
  String? courseName;
  String? title;
  String? subtitle;
  String? notes;
  String? addedDate;

  NotesModel.fromJson(Map<String, dynamic> json) {
    notesId = int.parse(json['notes_id'].toString());
    userId = json['user_id'];
    username = json['username'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    courseName = json['course_name'];
    title = json['title'];
    subtitle = json['subtitle'];
    notes = json['notes'];
    addedDate = json['added_date'];
  }
}
