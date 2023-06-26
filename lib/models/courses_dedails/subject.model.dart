class CoursesSubject {
  int? id;
  String? subjectName;
  String? dateAdded;
  List? userNotes;
  List<List<SubjectContent>>? subjectContent;
  List<ContentFlashCard>? flashCard;

  CoursesSubject({
    this.id,
    this.subjectName,
    this.dateAdded,
    this.userNotes,
    this.subjectContent,
    this.flashCard,
  });

//working
  CoursesSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    dateAdded = json['date_added'];
    //usernmode
    //content
    if (json["subject_content"] != null) {
      Set<String> titleSet = {};
      List<SubjectContent> tempDate = [];

      // get list of subject contant
      for (var element in json["subject_content"]) {
        tempDate.add(SubjectContent.fromJson(element));
        titleSet.add(element["title"]);
      }

      // fillter list from title to get list of sub-titles
      List<List<SubjectContent>> subjectContent = [];
      for (var element in titleSet) {
        List<SubjectContent> title1 = [];
        for (var e in tempDate) {
          if (element == e.title) {
            title1.add(e);
          }
        }
        subjectContent.add(title1);
      }

      // // filter flash card by sub-title from subject
      // if (json['flashcards'] != null) {
      //   for (var element in tempDate) {
      //     List data = [];
      //     for (var e1 in json['flashcards']) {
      //       ContentFlashCard flashCard = ContentFlashCard.fromJson(e1);
      //       // print(flashCard.subTitle);
      //       if (element.subTitle == flashCard.subTitle) {
      //         data.add(flashCard);
      //         // print("${element.subTitle} = ${flashCard.subTitle}");
      //       }
      //     }
      //     print(data);
      //   }
      // }

      this.subjectContent = subjectContent;
    }

    // get flash cards
    if (json['flashcards'] != null) {
      List<ContentFlashCard> data = [];
      for (var e1 in json['flashcards']) {
        ContentFlashCard flashCard = ContentFlashCard.fromJson(e1);
        data.add(flashCard);
      }
      flashCard = data;
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
}

class ContentFlashCard {
  int? flashcardId;
  String? subTitle;
  String? flashcardImageLink;
  String? flashcardContent;
  String? dateAdded;

  ContentFlashCard.fromJson(Map<String, dynamic> json) {
    flashcardId = json['flashcard_id'];
    subTitle = json['sub_title'];
    flashcardImageLink = json['flashcard_image_link'];
    flashcardContent = json['flashcard_content'];
    dateAdded = json['date_added'];
  }
}
