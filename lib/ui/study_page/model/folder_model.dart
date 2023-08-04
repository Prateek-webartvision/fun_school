class AppFolderModel {
  int? folderId;
  String? userId;
  String? folderTitle;
  String? datePosted;

  AppFolderModel.fromJson(Map<String, dynamic> json) {
    folderId = json['folder_id'];
    userId = json['user_id'];
    folderTitle = json['folder_title'];
    datePosted = json['date_posted'];
  }

  @override
  String toString() {
    return "$folderId, $userId, $folderTitle, $datePosted";
  }
}
