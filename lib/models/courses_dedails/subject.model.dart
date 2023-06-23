class CoursesSubject {
  int? id;
  String? subjectName;
  String? dateAdded;
  List? userNotes;
  List<List<SubjectContent>>? subjectContent;

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
      Set<String> _titleSet = {};
      List<SubjectContent> _tempDate = [];
      for (var element in json["subject_content"]) {
        _tempDate.add(SubjectContent.fromJson(element));
        _titleSet.add(element["title"]);
      }

      List<List<SubjectContent>> subjectContent = [];
      for (var element in _titleSet) {
        List<SubjectContent> title1 = [];

        for (var e in _tempDate) {
          if (element == e.title) {
            title1.add(e);
          }
        }
        subjectContent.add(title1);
      }

      // print(subjectContent);

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

  // @override
  // String toString() {
  //   return "$title";
  // }
}
