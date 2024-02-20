import 'package:fun_school/models/user/user.model.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/network/url/app_urls.dart';
import 'package:fun_school/utils/app_utils.dart';

import 'auth.dart';

class AuthRepository extends Auth {
  static AuthRepository? _init;
  AuthRepository._();
  static AuthRepository get instance => _init ??= AuthRepository._();

  @override
  Future createAccountWithEmailPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    final userData = <String, String>{};
    userData["username"] = username;
    userData['email'] = email;
    userData['password'] = password;

    return await api
        .postApi(AppUrls.registerUrl, params: userData)
        .then((value) {
      if (value["code"] == 200) {
        return value["message"];
      } else {
        throw value["message"];
      }
    });
  }

  //* sign in
  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final userData = <String, String>{};
    userData['email'] = email;
    userData['password'] = password;

    final res = await api.postApi(AppUrls.signInUrl, params: userData);

    if (res["code"] == 200) {
      UserModel userModel = UserModel(
        userId: int.parse(res['user_id'].toString()),
        userName: res['username'],
        userEmail: res['email'],
        about: res['about'],
        userType: res['user_type'],
        regDate: res['reg_date'],
        status: res['status'],
      );
      return userModel;
    } else {
      throw res["message"];
    }
  }

  @override
  Future changePassword({
    required String oldPassword,
    required String newPassword,
    required String conformNewPassword,
  }) async {
    final data = <String, String>{};

    data["user_id"] = AppStorage.user.currentUser()!.userId.toString();
    data["old_password"] = oldPassword;
    data["new_password"] = newPassword;
    data["new_password_repeat"] = conformNewPassword;

    await api.postApi(AppUrls.changePassword, params: data).then((value) {
      // if (value['code'] == 200) {
      // } else {
      // return value
      // print(value);
      AppUtils.showSnack(value["message"]);
    }).onError((error, stackTrace) {
      AppUtils.showSnack(error.toString());
    });
  }

  //* send forgot otp
  Future<String> sendForgotOtp(String email) async {
    Map<String, String> param = {};
    param['email'] = email;

    final res = await api.getApi(AppUrls.forgotPassword, params: param);
    if (res['code'] == 200) {
      return "done";
    } else {
      throw res['message'];
    }
  }

  //* send forgot otp
  Future<String> verifyOtp(String email, String otp) async {
    Map<String, String> param = {};
    param['email'] = email;
    param['otp'] = otp;

    final res = await api.getApi(AppUrls.forgotPasswordOtp, params: param);

    if (res['code'] == 200) {
      return "done";
    } else {
      throw res['message'];
    }
  }

  //* send forgot otp
  Future<String> changeForgotPassword(
      String email, String password, String confirmPassword) async {
    Map<String, String> param = {};
    param['email'] = email;
    param['new_password'] = password;
    param['new_password_repeat'] = confirmPassword;

    final res = await api.getApi(AppUrls.forgotPasswordChange, params: param);

    if (res['code'] == 200) {
      return "done";
    } else {
      throw res['message'];
    }
  }
}
