class CoursesSubject {
  int? id;
  String? subjectName;
  String? dateAdded;
  List? userNotes;
  List? subjectContent;

  CoursesSubject({
    this.id,
    this.subjectName,
    this.dateAdded,
  });

  CoursesSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    dateAdded = json['date_added'];
  }
}
