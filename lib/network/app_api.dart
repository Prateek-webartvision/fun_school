import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:citycloud_school/network/api_service.dart';
import 'package:citycloud_school/network/exception/k_exceptions.dart';
import 'package:http/http.dart' as http;

class AppApi extends ApiService {
  final String _get = "GET";
  final String _post = "POST";

  // get method
  @override
  Future getApi(String url, {Map<String, String>? params}) async {
    Uri uri = Uri.parse(url);
    late Uri finalUri;

    if (params != null) {
      finalUri = Uri(scheme: uri.scheme, host: uri.host, path: uri.path, queryParameters: params);
    } else {
      finalUri = uri;
    }

    http.MultipartRequest request = http.MultipartRequest(_get, finalUri);

    try {
      http.StreamedResponse response = await request.send().timeout(timeOutDuretion);

      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else {
        throw response.reasonPhrase!;
      }
    } on SocketException {
      throw KInternetException();
    } on TimeoutException {
      throw KRequestTimeOutException();
    } catch (e) {
      rethrow;
    }
  }

  // post Mehod
  @override
  Future postApi(String url, {Map<String, dynamic>? params, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(url);
    late Uri finalUri;
    if (params != null) {
      finalUri = Uri(scheme: uri.scheme, host: uri.host, path: uri.path, queryParameters: params);
    } else {
      finalUri = uri;
    }

    http.MultipartRequest request = http.MultipartRequest(_post, finalUri);

    try {
      http.StreamedResponse response = await request.send().timeout(timeOutDuretion);

      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else {
        throw response.reasonPhrase!;
      }
    } on SocketException {
      throw KInternetException();
    } on TimeoutException {
      throw KRequestTimeOutException();
    } catch (e) {
      rethrow;
    }
  }
}
