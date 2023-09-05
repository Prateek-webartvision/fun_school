class CommunityDiscussionModel {
  int? discussionId;
  int? userId;
  String? username;
  String? aboutUser;
  String? userProfileImage;
  String? userType;
  String? topic;
  String? text;
  String? type;
  int? replysCount;
  int? repostsCount;
  int? likesCount;
  String? status;
  int? threadId;
  String? target;
  dynamic ogData;
  String? time;
  String? edited;
  List<Media>? media;
  List<Likes>? likes;
  List<Hashtags>? hashtags;

  CommunityDiscussionModel.fromJson(Map<String, dynamic> json) {
    discussionId = json['discussion_id'];
    userId = json["user_id"];
    username = json['username'];
    aboutUser = json['About_user'];
    userProfileImage = json['user_profile_image'];
    userType = json['user_type'];
    topic = json['topic'];
    text = json['text'];
    type = json['type'];
    replysCount = json['replys_count'];
    repostsCount = json['reposts_count'];
    likesCount = json['likes_count'];
    status = json['status'];
    threadId = json['thread_id'];
    target = json['target'];
    ogData = json['og_data'];
    time = json['time'];
    edited = json['edited'];
    // media
    if (json['media'] != null) {
      List<Media> media = [];
      for (var element in json['media']) {
        final m = Media.fromJson(element);
        media.add(m);
      }
      this.media = media;
    }
    // Likes
    if (json['likes'] != null) {
      List<Likes> likes = [];
      for (var element in json['likes']) {
        final like = Likes.fromJson(element);
        likes.add(like);
      }
      this.likes = likes;
    }

    //hashtags
    if (json['hashtags'] != null) {
      List<Hashtags> hashtags = [];
      for (var element in json['hashtags']) {
        final tag = Hashtags.fromJson(element);
        hashtags.add(tag);
      }
      this.hashtags = hashtags;
    }
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};

    json['discussion_id'] = discussionId;
    json["user_id"] = userId;
    json['username'] = username;
    json['About_user'] = aboutUser;
    json['user_profile_image'] = userProfileImage;
    json['user_type'] = userType;
    json['topic'] = topic;
    json['text'] = text;
    json['type'] = type;
    json['replys_count'] = replysCount;
    json['reposts_count'] = repostsCount;
    json['likes_count'] = likesCount;
    json['status'] = status;
    json['thread_id'] = threadId;
    json['target'] = target;
    json['og_data'] = ogData;
    json['time'] = time;
    json['edited'] = edited;
    json['likes'] = likes;
    json['media'] = media;

    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Likes {
  int? likeId;
  int? userId;
  String? username;
  String? aboutUser;
  String? userProfileImage;
  String? userType;
  String? time;

  Likes.fromJson(Map<String, dynamic> json) {
    likeId = json['like_id'];
    userId = json['user_id'];
    username = json['username'];
    aboutUser = json['About_user'];
    userProfileImage = json['user_profile_image'];
    userType = json['user_type'];
    time = json['time'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['like_id'] = likeId;
    json['user_id'] = userId;
    json['username'] = username;
    json['About_user'] = aboutUser;
    json['user_profile_image'] = userProfileImage;
    json['user_type'] = userType;
    json['time'] = time;

    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Media {
  int? mediaId;
  int? pubId;
  String? type;
  String? src;
  String? time;

  Media.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    pubId = json['pub_id'];
    type = json['type'];
    src = json['src'];
    time = json['time'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['media_id'] = mediaId;
    json['pub_id'] = pubId;
    json['type'] = type;
    json['src'] = src;
    json['time'] = time;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Hashtags {
  int? hashtagId;
  String? pubId;
  String? hashtag;
  String? time;

  Hashtags.fromJson(Map<String, dynamic> json) {
    hashtagId = json['hashtag_id'];
    pubId = json['pub_id'];
    hashtag = json['hashtag'];
    time = json['time'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['hashtag_id'] = hashtagId;
    json['pub_id'] = pubId;
    json['hashtag'] = hashtag;
    json['time'] = time;

    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class TrandingHashtags {
  int? hashtageId;
  String? hashtag;

  TrandingHashtags.fromJson(Map<String, dynamic> json) {
    hashtageId = json["hashtage_id"];
    hashtag = json["hashtag"];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json["hashtage_id"] = hashtageId;
    json["hashtag"] = hashtag;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
