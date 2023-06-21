class UserModel {
  String? userid;
  String? userName;
  String? userEmail;
  String? userProfile;
  String? about;
  String? userType;
  String? regDate;
  String? status;

  UserModel({
    this.userName,
    this.about,
    this.userType,
    this.regDate,
    this.status,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json["username"];
    about = json["about"];
    userType = json["user_type"];
    regDate = json["reg_date"];
    status = json["status"];
  }

  // copy with
  UserModel.copyWuth({
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
    userData["username"] = userName;
    userData["about"] = about;
    userData["user_type"] = userType;
    userData["reg_date"] = regDate;
    userData["status"] = status;
    return userData;
  }
}
