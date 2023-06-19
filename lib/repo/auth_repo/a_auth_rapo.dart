import '../../network/app_api.dart';

abstract class AuthRepo {
  final AppApi api = AppApi();

  /// Auth reop is user to heandle user opration like [signup], [delete user], [signin], [logout]
  /// [signup] is the method to register new user
  Future<dynamic> createAccountWithEmailPassword({required String username, required String email, required String password});

  // signin method
  Future<dynamic> signInWithEmailPassword({required String email, required String password});
}
