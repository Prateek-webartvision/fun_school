import 'package:citycloud_school/models/user/user.model.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/uitls/app_utils.dart';

import 'a_auth_rapo.dart';

class AuthRepository extends AuthRepo {
  static AuthRepository? _init;
  AuthRepository._();
  static AuthRepository get instance => _init ??= AuthRepository._();

  @override
  Future createAccountWithEmailPassword({required String username, required String email, required String password}) async {
    final userData = <String, String>{};
    userData["username"] = username;
    userData['email'] = email;
    userData['password'] = password;

    return await api.postApi(AppUrls.registerUrl, params: userData).then((value) {
      if (value["code"] == 200) {
        return value["message"];
      } else {
        throw value["message"];
      }
    }).onError((error, stackTrace) {
      AppUtils.showSnack("$error");
    });
  }

  // sign in
  @override
  Future<UserModel> signInWithEmailPassword({required String email, required String password}) async {
    final userData = <String, String>{};
    userData['email'] = email;
    userData['password'] = password;

    return await api.postApi(AppUrls.signInUrl, params: userData).then((value) {
      if (value["code"] == 200) {
        UserModel userModel = UserModel(
          userid: value['user_id'],
          userName: value['username'],
          userEmail: value['email'],
          about: value['about'],
          userType: value['user_type'],
          regDate: value['reg_date'],
          status: value['status'],
        );
        return userModel;
      } else {
        throw value["message"];
      }
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  @override
  Future changePassword({required String oldPassword, required String newPassword, required String conformNewPassword}) async {
    final data = <String, String>{};

    data["user_id"] = AppStorage.user.currentUser()!.userid.toString();
    data["old_password"] = oldPassword;
    data["new_password"] = newPassword;
    data["new_password_repeat"] = conformNewPassword;

    await api.postApi(AppUrls.changePassword, params: data).then((value) {
      // if (value['code'] == 200) {
      // } else {
      // return value
      print(value);
      AppUtils.showSnack(value["message"]);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }
}
