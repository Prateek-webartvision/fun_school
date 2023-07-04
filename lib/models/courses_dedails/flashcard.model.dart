class FlashCardModel {
  int? flashcardId;
  String? subTitle;
  String? flashcardImageLink;
  String? flashcardContent;
  bool? flashcardResult;
  String? dateAdded;

  FlashCardModel.fromJson(Map<String, dynamic> json) {
    flashcardId = json['flashcard_id'];
    subTitle = json['sub_title'];
    flashcardImageLink = json['flashcard_image_link'];
    flashcardContent = json['flashcard_content'];
    if (json['flashcard_result'] != null) {
      flashcardResult = bool.parse(json['flashcard_result'].toString());
    }
    dateAdded = json['date_added'];
  }

  copyWith({bool? flashcardResult}) {
    this.flashcardResult = flashcardResult ?? this.flashcardResult;
  }
}
