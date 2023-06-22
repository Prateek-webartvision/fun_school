class CoursesSubject {
  int? id;
  String? subjectName;
  String? dateAdded;
  List? userNotes;
  List<SubjectContent>? subjectContent;

  CoursesSubject({
    this.id,
    this.subjectName,
    this.dateAdded,
    this.userNotes,
    this.subjectContent,
  });

  CoursesSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    dateAdded = json['date_added'];
    //usernmode
    //content
    if (json["subject_content"] != null) {
      List<SubjectContent> subjectContent = [];
      for (var element in json["subject_content"]) {
        subjectContent.add(SubjectContent.fromJson(element));
      }
      this.subjectContent = subjectContent;
    }
  }
}

class SubjectContent {
  int? id;
  String? title;
  String? subTitle;
  String? contentType;
  String? contentData;
  String? dateAdded;

  SubjectContent({
    this.id,
    this.title,
    this.subTitle,
    this.contentType,
    this.contentData,
    this.dateAdded,
  });

  SubjectContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    contentType = json['content_type'];
    contentData = json['content_data'];
    dateAdded = json['date_added'];
  }

  @override
  String toString() {
    return "$title";
  }
}
