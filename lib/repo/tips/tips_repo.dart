import 'package:citycloud_school/network/url/app_urls.dart';

import '../../network/app_api.dart';

class TipsRepository {
  static final _api = AppApi();

  static Future<List<TipsModel>> get getTips async {
    final res = await _api.getApi(AppUrls.getTips);
    List<TipsModel> temp = [];
    for (var element in res) {
      final tip = TipsModel.fromJson(element);
      temp.add(tip);
    }
    return temp;
  }
}

class TipsModel {
  int? tipId;
  String? tipTitle;
  String? title;
  String? tipContent;
  String? datePosted;

  TipsModel.fromJson(Map<String, dynamic> json) {
    tipId = int.parse(json['tip_id'].toString());
    tipTitle = json['tip_title'];
    title = json['title'];
    tipContent = json['tip_content'];
    datePosted = json['date_posted'];
  }
}
