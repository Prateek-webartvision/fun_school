abstract class AuthRepo {
  /// Auth reop is user to heandle user opration like [signup], [delete user], [signin], [logout]
  /// [signup] is the method to register new user
  Future<dynamic> createAccountWithEmailPassword({required String username, required String email, required String password});
}
