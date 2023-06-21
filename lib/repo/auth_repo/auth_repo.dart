import 'package:citycloud_school/models/user/user.model.dart';
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
}
