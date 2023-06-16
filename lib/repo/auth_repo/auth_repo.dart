import 'package:citycloud_school/network/api/app_urls.dart';

import '../../network/app_api.dart';
import 'a_auth_rapo.dart';

class AuthRepository extends AuthRepo {
  static AuthRepository? _init;
  AuthRepository._();
  static AuthRepository get instance => _init ??= AuthRepository._();

  final AppApi _api = AppApi();

  @override
  Future createAccountWithEmailPassword({required String username, required String email, required String password}) async {
    final userData = <String, String>{};
    userData["username"] = username;
    userData['email'] = email;
    userData['password'] = password;

    // await _api.postApi(AppUrls.registerUrl, params: userData);

    // AppApi()
    //     .postApi(
    //       AppUrls.registerUrl,
    //       params: {
    //         "username": "kundan",
    //         "email": "kd",
    //         "password": "password",
    //       },
    //     )
    //     .then((value) => print(value))
    //     .onError(
    //       (error, stackTrace) => print("error ${error.toString()}"),
    //     );
    print(userData);
    // return "kundan";
  }
}
