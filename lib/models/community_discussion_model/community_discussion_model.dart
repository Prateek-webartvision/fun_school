import '../../network/data/app_storage.dart';

abstract class DiscussionModel {
  int? discussionId;
  int? userId;
  String? username;
  String? aboutUser;
  String? userProfileImage;
  String? userType;
  String? topic;
  String? text;
  String? type;
  int? replyCount;
  int? rePostCount;
  int? likesCount;
  String? status;
  int? threadId;
  String? target;
  String? ogData;
  String? time;
  String? edited;
  List<Media>? media;
  List<Likes>? likes;
  bool isLiked = false;
  List<Hashtags>? hashtags;
  List<ReplyModel>? replies;

  DiscussionModel.fromJson(Map<String, dynamic> json) {
    discussionId = int.tryParse(json['discussion_id']);
    userId = (json["user_id"] != null) ? int.tryParse(json["user_id"]) : null;
    username = json['username'];
    aboutUser = json['About_user'];
    userProfileImage = json['user_profile_image'];
    userType = json['user_type'];
    topic = json['topic'];
    text = json['text'];
    type = json['type'];
    replyCount = int.tryParse(json['replys_count']);
    rePostCount = int.tryParse(json['reposts_count']);
    likesCount = int.tryParse(json['likes_count']);
    status = json['status'];
    threadId = int.tryParse(json['thread_id']);
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
        if (like.userId! == AppStorage.user.currentUser()!.userId!) {
          isLiked = true;
        }
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

    // replys
    if (json['replys'] != null) {
      List<ReplyModel> reply = [];
      for (var element in json['replys']) {
        final rp = ReplyModel.fromJson(element);
        reply.add(rp);
      }
      replies = reply;
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
    json['replys_count'] = replyCount;
    json['reposts_count'] = rePostCount;
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

class CommunityDiscussionModel extends DiscussionModel {
  CommunityDiscussionModel.fromJson(super.json) : super.fromJson();
}

class CommunityDiscussionUserModel extends DiscussionModel {
  String? posts;
  String? followers;
  String? following;

  CommunityDiscussionUserModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    posts = json['posts'];
    followers = json['followers'];
    following = json['following'];
  }

  @override
  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['posts'] = posts;
    json['followers'] = followers;
    json['following'] = following;
    json.addAll(super.toJson);
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
    likeId = int.tryParse(json['like_id']);
    userId = int.tryParse(json['user_id']);
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
    mediaId = int.tryParse(json['media_id']);
    pubId = int.tryParse(json['pub_id']);
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
    hashtagId = int.tryParse(json['hashtag_id']);
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

class TrendingHashTags {
  int? hashTagId;
  String? hashtag;

  TrendingHashTags.fromJson(Map<String, dynamic> json) {
    hashTagId = int.tryParse(json["hashtage_id"]);
    hashtag = json["hashtag"];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json["hashtage_id"] = hashTagId;
    json["hashtag"] = hashtag;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class ReplyModel {
  String? discussionId;
  String? userId;
  String? userName;
  String? aboutUser;
  String? userProfileImage;
  String? userType;
  String? text;
  String? type;
  String? likesCount;
  String? status;
  String? threadId;
  String? target;
  String? ogData;
  String? time;
  String? edited;
  List<Media>? medias;

  ReplyModel.fromJson(json) {
    discussionId = json["discussion_id"];
    userId = json["user_id"];
    userName = json["username"];
    aboutUser = json["About_user"];
    userProfileImage = json["user_profile_image"];
    userType = json["user_type"];
    text = json["text"];
    type = json["type"];
    likesCount = json["likes_count"];
    status = json["status"];
    threadId = json["thread_id"];
    target = json["target"];
    ogData = json["og_data"];
    time = json["time"];
    edited = json["edited"];
    if (json['media'] != null) {
      List<Media> temp = [];
      for (var element in json['media']) {
        final md = Media.fromJson(element);
        temp.add(md);
      }
      medias = temp;
    }
  }
}
