import 'package:citycloud_school/network/url/app_urls.dart';

import '../../network/app_api.dart';

class TipsRepository {
  static final _api = AppApi();

  static Future<List<TipsModel>?> getTips() async {
    return await _api.getApi(AppUrls.getTips).then((value) {
      List<TipsModel> temp = [];
      for (var element in value) {
        final tip = TipsModel.fromJson(element);
        temp.add(tip);
      }
      return temp;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class TipsModel {
  int? tipId;
  String? tipTitle;
  String? title;
  String? tipContent;
  String? datePosted;

  TipsModel.fromJson(Map<String, dynamic> json) {
    tipId = json['tip_id'];
    tipTitle = json['tip_title'];
    title = json['title'];
    tipContent = json['tip_content'];
    datePosted = json['date_posted'];
  }
}
