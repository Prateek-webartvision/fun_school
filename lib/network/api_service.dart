abstract class ApiService {
  final timeOutDuration = const Duration(seconds: 60);
  //get,
  Future<dynamic> getApi(
    String url, {
    Map<String, String>? params,
  });
  //post,
  Future<dynamic> postApi(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  });
}
