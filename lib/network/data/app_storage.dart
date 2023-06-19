import 'package:get_storage/get_storage.dart';

import 'user_storage.dart';

class AppStorage extends User {
  static AppStorage? _init;
  AppStorage._() : super(_box);

  static AppStorage get _instance => _init ??= AppStorage._();

  static final GetStorage _box = GetStorage();
  static User user = _instance;
}
