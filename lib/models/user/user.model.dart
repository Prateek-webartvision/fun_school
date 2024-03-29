class UserModel {
  int? userId;
  String? userName;
  String? userEmail;
  String? userProfile;
  String? about;
  String? userType;
  String? regDate;
  String? status;

  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.about,
    this.userType,
    this.regDate,
    this.status,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    userName = json["username"];
    userEmail = json["email"];
    about = json["about"];
    userType = json["user_type"];
    regDate = json["reg_date"];
    status = json["status"];
  }

  // copy with
  UserModel.copyWith({
    String? userName,
    String? about,
    String? userType,
    // String? regDate;
    String? status,
  }) {
    this.userName = userName ?? this.userName;
    this.about = about ?? this.about;
    this.userType = userType ?? this.userType;
    this.status = status ?? this.status;
  }

  toJson() {
    Map userData = <String, dynamic>{};
    userData["user_id"] = userId;
    userData["username"] = userName;
    userData["email"] = userEmail;
    userData["about"] = about;
    userData["user_type"] = userType;
    userData["reg_date"] = regDate;
    userData["status"] = status;
    return userData;
  }
}
