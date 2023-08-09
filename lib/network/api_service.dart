abstract class ApiService {
  final timeOutDuretion = const Duration(seconds: 10);
  //get,
  Future<dynamic> getApi(String url, {Map<String, String>? params, Map<String, dynamic>? body});
  //post,
  Future<dynamic> postApi(String url, {Map<String, dynamic>? params, Map<String, dynamic>? body});
}
