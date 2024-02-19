import 'package:fun_school/network/app_api.dart';
import 'package:fun_school/network/url/app_urls.dart';

class PowerSummaryRepository {
  static final _api = AppApi();

  static Future<List<PowerSummaryModel>?> getSummary(String subjectId) async {
    return await _api.getApi(AppUrls.getPowerSummary).then((value) {
      if (value != null) {
        List<PowerSummaryModel> summaries = [];
        for (var element in value) {
          final summary = PowerSummaryModel.fromJson(element);
          if (summary.subjectId == subjectId) {
            summaries.add(summary);
          }
        }
        return summaries;
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}

class PowerSummaryModel {
  int? powerSummaryId;
  String? subjectName;
  String? subjectId;
  String? title;
  String? subTitle;
  String? uRL;
  String? datePosted;

  PowerSummaryModel.fromJson(Map<String, dynamic> json) {
    powerSummaryId = int.tryParse(json['power_summary_id']);
    subjectName = json['subject_name'];
    subjectId = json['subject_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    uRL = json['URL'];
    datePosted = json['date_posted'];
  }
}
