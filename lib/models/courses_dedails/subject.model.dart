class CoursesSubject {
  int? id;
  String? subjectName;
  String? dateAdded;
  List? userNotes;
  List<List<SubjectContent>>? subjectContent;
  List<ContentFlashCard>? flashCard;
  List<ContentVideo>? videos;

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

    // get video deta
    if (json['video'] != null) {
      List<ContentVideo> videos = [];
      for (var element in json['video']) {
        videos.add(ContentVideo.fronJson(element));
      }
      this.videos = videos;
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

class ContentVideo {
  int? videoId;
  String? subTitle;
  String? videoLink;
  String? dateAdded;

  ContentVideo.fronJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    subTitle = json['sub_title'];
    videoLink = json['video_link'];
    dateAdded = json['date_added'];
  }
}
