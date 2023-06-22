class CoursesSubject {
  int? id;
  String? subjectName;
  String? dateAdded;
  List? userNotes;
  List<SubjectContent>? subjectContent;
  Set<String> _titleSet = {};

  CoursesSubject({
    this.id,
    this.subjectName,
    this.dateAdded,
    this.userNotes,
    this.subjectContent,
  });

//working
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
        _titleSet.add(element["title"]);
      }

      for (var element in _titleSet) {
        List<SubjectContent> title1 = [];

        for (var e in subjectContent) {
          if (element == e.title) {
            title1.add(e);
          }
        }
        print("sv $title1");
      }
      // print(_titleSet);

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
    id = json['subject_content_id'];
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
