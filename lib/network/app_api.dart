import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fun_school/network/api_service.dart';
import 'package:fun_school/network/exception/k_exceptions.dart';
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
      finalUri = Uri(
          scheme: uri.scheme,
          host: uri.host,
          path: uri.path,
          queryParameters: params);
    } else {
      finalUri = uri;
    }

    http.MultipartRequest request = http.MultipartRequest(_get, finalUri);

    try {
      http.StreamedResponse response =
          await request.send().timeout(timeOutDuration);

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

  // post Method
  @override
  Future postApi(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) async {
    Uri uri = Uri.parse(url);
    late Uri finalUri;
    if (params != null) {
      finalUri = Uri(
          scheme: uri.scheme,
          host: uri.host,
          path: uri.path,
          queryParameters: params);
    } else {
      finalUri = uri;
    }

    http.MultipartRequest request = http.MultipartRequest(_post, finalUri);

    try {
      http.StreamedResponse response =
          await request.send().timeout(timeOutDuration);

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

  Future postWithFiles(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, List<File>>? files,
  }) async {
    Uri uri = Uri.parse(url);
    late Uri finalUri;
    if (params != null) {
      finalUri = Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
        queryParameters: params,
      );
    } else {
      finalUri = uri;
    }

    http.MultipartRequest request = http.MultipartRequest(_post, finalUri);

    try {
      if (body != null && body.isNotEmpty) {
        Map<String, String> fields =
            body.map((key, value) => MapEntry(key, value.toString()));
        request.fields.addAll(fields);
      }

      if (files != null && files.isNotEmpty) {
        for (var element in files.entries) {
          List<http.MultipartFile> mFiles = [];
          for (var path in element.value) {
            http.MultipartFile multipartFile =
                await http.MultipartFile.fromPath(element.key, path.path);
            mFiles.add(multipartFile);
          }
          request.files.addAll(mFiles);
        }
      }

      final total = request.contentLength;

      log(total.toString());

      http.StreamedResponse response = await request.send();

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
