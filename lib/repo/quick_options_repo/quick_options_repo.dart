import '../../network/app_api.dart';

class QuickOptionRepository {
  static final _api = AppApi();

  static addNote({required String noteTitle, required int subjectId, required String note}) async {
    Map data = <String, dynamic>{};
    data['user_id'] = "ds";
    data['subject_id'] = "ds";
    data['notes'] = "ds";

    await Future.delayed(Duration(seconds: 2));
    print(data);
    return "Done";
  }
}
