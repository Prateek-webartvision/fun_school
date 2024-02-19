import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/url/app_urls.dart';

class PaworSummaryRepository {
  static final _api = AppApi();

  static Future<List<PaworSummaryModel>?> getSummary(String subjectid) async {
    return await _api.getApi(AppUrls.getPaworSummary).then((value) {
      if (value != null) {
        List<PaworSummaryModel> summarys = [];
        for (var element in value) {
          final summary = PaworSummaryModel.fromJson(element);
          if (summary.subjectId == subjectid) {
            summarys.add(summary);
          }
        }
        return summarys;
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class PaworSummaryModel {
  int? powerSummaryId;
  String? subjectName;
  String? subjectId;
  String? title;
  String? subTitle;
  String? uRL;
  String? datePosted;

  PaworSummaryModel.fromJson(Map<String, dynamic> json) {
    powerSummaryId = json['power_summary_id'];
    subjectName = json['subject_name'];
    subjectId = json['subject_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    uRL = json['URL'];
    datePosted = json['date_posted'];
  }
}
