import '../../network/app_api.dart';

abstract class Auth {
  final AppApi api = AppApi();

  /// Auth repo is use to handle user operation like [SIGHUP], [DELETE], [SIGNING], [LOGOUT]
  /// [SIGHUP] is the method to register new user
  Future<dynamic> createAccountWithEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  //* Sign-In user with email and password
  Future<dynamic> signInWithEmailPassword({
    required String email,
    required String password,
  });

  //* Change old password
  Future<dynamic> changePassword({
    required String oldPassword,
    required String newPassword,
    required String conformNewPassword,
  });
}
