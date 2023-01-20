import 'dart:convert';

import 'package:dio/dio.dart';
import '../Models/Api/current_user.dart';

class ApiClient {

  static const baseUrl = "https://flutter.linked4med.com/api/";

  static Dio getDio() {
    String username = 'FlutterDev@LuminousKey.com';
    String password = 'Flutter2023';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    BaseOptions options = BaseOptions(
        followRedirects: false,
        baseUrl: baseUrl,
        responseType: ResponseType.plain,
        connectTimeout: 60000000,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "headerKey": "qLI{?gfe@@k6Uus}+",
          "X-Requested-With": "XMLHttpRequest",
          "Authorization": "$basicAuth",
        });

    Dio dio = Dio(options);

    return dio;
  }

}
