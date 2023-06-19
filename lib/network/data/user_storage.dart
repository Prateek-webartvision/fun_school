import 'package:get_storage/get_storage.dart';

import '../../models/user/user.model.dart';

class User {
  late GetStorage _userBox;
  final String _userKey = "userKey";

  User(GetStorage box) {
    _userBox = box;
  }

  //read user
  UserModel? currentUser() {
    var user = _userBox.read(_userKey);
    if (user != null) {
      return UserModel.fromJson(user!);
    } else {
      return null;
    }
  }

  //save user
  saveUser(UserModel user) {
    _userBox.write(_userKey, user.toJson());
  }

  //remode user
  removeUser() {
    _userBox.remove(_userKey);
  }
}
