class FlashCardModel {
  int? flashcardId;
  String? subTitle;
  String? flashcardImageLink;
  String? flashcardContent;
  String? dateAdded;

  FlashCardModel.fromJson(Map<String, dynamic> json) {
    flashcardId = json['flashcard_id'];
    subTitle = json['sub_title'];
    flashcardImageLink = json['flashcard_image_link'];
    flashcardContent = json['flashcard_content'];
    dateAdded = json['date_added'];
  }
}
