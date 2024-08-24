import 'package:app_pragma_prueba/config/api/cat/loading_interceptors.dart';
import 'package:app_pragma_prueba/config/constants/utils.dart';
import 'package:dio/dio.dart';

import 'interceptors.dart';

enum ApiEnumTypeAuthentication { header, queryParam, none }

class Api {
  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Future<Dio> dio({
    bool loading = false,
    ApiEnumTypeAuthentication authorization = ApiEnumTypeAuthentication.none,
  }) async {
    Map<String, dynamic> mapHeader = {
      'Accept': 'application/json',
    };

    switch (authorization) {
      case ApiEnumTypeAuthentication.header:
        mapHeader["x-api-key"] = Utils().apiKey;
        break;

      case ApiEnumTypeAuthentication.none:
      default:
        break;
    }

    var dio = Dio(
      BaseOptions(
        baseUrl: Utils().apiUrl,
        contentType: 'application/json; charset=UTF-8',
        headers: mapHeader,
        receiveDataWhenStatusError: true,
      ),
    );

    if (loading) {
      dio.interceptors.addAll({
        LoadingInterceptor(),
      });
    }

    dio.interceptors.addAll({
      AppInterceptors(
        dio,
        authQuery: authorization == ApiEnumTypeAuthentication.queryParam,
      ),
    });

    return dio;
  }
}
