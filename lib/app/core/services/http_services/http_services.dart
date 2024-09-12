import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:hero/app/data/constants/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../local_db_services/local_db_services.dart';

class APIService extends getx.GetxService {
  late final Dio _dio;
  late final CacheOptions _dioCacheOption;

  static APIService get instance => getx.Get.find<APIService>();

  final serviceLocalDb = getx.Get.find<LocalDBService>();

  static const String liveUrl = 'https://app.carpedialabs.com/api/';

  static const String devUrl = 'https://app.carpedialabs.com/api/';

  String? url = devUrl;

  dynamic route;

  APIService({this.url, this.route}) {
    BaseOptions options =
        BaseOptions(receiveTimeout: 20.seconds, connectTimeout: 20.seconds);
    _dio = Dio(options);

    _dioCacheOption = CacheOptions(
      store: MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    // LOG HERE
    if (kDebugMode) {
      _dio.interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    }

    //CACHE HERE
    // _dio.interceptors.add(DioCacheInterceptor(options: _dioCacheOption));
  }

  Future<dynamic> get(
      {String? endpoint, String? fullUrl, String? version}) async {
    Response response;
    try {
      String completedURL =
          (url ?? (devUrl) + (version ?? 'v1') + (endpoint ?? ""));
      response = await _dio.get(
          (fullUrl == null) ? completedURL + addLang(completedURL) : fullUrl,
          options: Options(
            headers: {
              "authorization": "Bearer ${serviceLocalDb.getToken()}",
              "Accept": "application/json",
              "Content-Type": "application/json",
              "User-Agent":
                  "${LocalDBService.instance.getDeviceModel()}-CarpediaApp"
            },
          ));
      return response;
    } on DioException catch (error) {
      String er = _handleError(error);
      throw CustomException(er, error.response?.statusCode ?? 0);
    }
  }

  Future post(var body,
      {String? endpoint,
      String? fullUrl,
      String? version,
      Map<String, dynamic>? header}) async {
    try {
      if (body is Map<String, dynamic>) {
        body['lang'] =
            (LocalDBService.instance.getLanguage() == 'English') ? 'en' : 'ms';
      } else if (body is FormData) {
        body.fields.add(MapEntry(
            'lang',
            (LocalDBService.instance.getLanguage() == 'English')
                ? 'en'
                : 'ms'));
      }

      String completedURL =
          (url ?? (devUrl) + (version ?? 'v1') + (endpoint ?? ""));
      Response response =
          await _dio.post((fullUrl == null) ? completedURL : fullUrl,
              data: body,
              options: Options(
                headers: header ??
                    {
                      "Accept": "application/json",
                      "Content-Type": "application/json",
                      "authorization": "Bearer ${serviceLocalDb.getToken()}",
                      "User-Agent":
                          "${LocalDBService.instance.getDeviceModel()}-CarpediaApp"
                    },
              ));
      return response;
    } on DioException catch (error) {
      String er = _handleError(error);
      log(er);
      throw CustomException(er, error.response?.statusCode ?? 0);
    }
  }

  Future put(var body, {String? endpoint, String? fullUrl}) async {
    try {
      Response response = await _dio.put(
          (fullUrl == null) ? (url ?? devUrl + (endpoint ?? "")) : fullUrl,
          data: body,
          options: Options(
            headers: {
              "authorization": "Bearer ${serviceLocalDb.getToken()}",
              "Accept": "application/json",
              "Content-Type": "application/json",
              "User-Agent":
                  "${LocalDBService.instance.getDeviceModel()}-CarpediaApp"
            },
          ));
      return response;
    } on DioException catch (error) {
      String er = _handleError(error);
      log(er);
      throw CustomException(er, error.response?.statusCode ?? 0);
    }
  }

  Future<dynamic> delete({String? endpoint, String? fullUrl}) async {
    Response response;
    try {
      response = await _dio.delete(
          (fullUrl == null) ? (url ?? devUrl + (endpoint ?? "")) : fullUrl,
          options: Options(
            headers: {
              "authorization": "Bearer ${serviceLocalDb.getToken()}",
              "Accept": "application/json",
              "Content-Type": "application/json",
              "User-Agent":
                  "${LocalDBService.instance.getDeviceModel()}-CarpediaApp"
            },
          ));
      return response;
    } on DioException catch (error) {
      String er = _handleError(error);
      log(er);
      throw CustomException(er, error.response?.statusCode ?? 0);
    }
  }

  String _handleError(DioException error) {
    String errorDescription = "";
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioExceptionType.connectionError:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        String errorMessage = "";
        if (error.response?.data["errors"] != null) {
          errorMessage =
              "${error.response?.data["message"]}\n${concatenateErrorMessages(error.response?.data["errors"])}";
        } else {
          errorMessage = error.response?.data["message"] ??
              "Something went wrong, please try again later";
        }

        errorDescription = errorMessage;
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        errorDescription = "Error Bad Certificate";
        break;
      case DioExceptionType.unknown:
        errorDescription = "Unknown Error occur";
        break;
    }
    return errorDescription;
  }
}

String addLang(String fullUrl) {
  String urlLang = "";
  if (fullUrl.contains('?')) {
    urlLang =
        "&lang=${(LocalDBService.instance.getLanguage() == 'English' ? 'en' : 'ms')}";
  } else {
    urlLang =
        "?lang=${(LocalDBService.instance.getLanguage() == 'English' ? 'en' : 'ms')}";
  }

  return urlLang;
}

String concatenateErrorMessages(Map<String, dynamic> errorMap) {
  List<String> messages = [];

  errorMap.forEach((key, value) {
    if (value is List) {
      messages.addAll([...value]);
    } else if (value is String) {
      messages.add(value);
    }
  });

  return messages
      .join('\n'); // Concatenate with newlines or any desired separator
}

class CustomException implements Exception {
  final String message;
  final int errorCode;

  CustomException(this.message, this.errorCode);

  @override
  String toString() {
    return 'CustomException: $message (Error Code: $errorCode)';
  }
}
