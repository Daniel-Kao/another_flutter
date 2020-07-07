import 'package:another_flutter/constants.dart';
import 'package:another_flutter/models/result_data.dart';
import 'package:dio/dio.dart';

import 'code.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = Dio(new BaseOptions(
        baseUrl: Constants.BASE_URL,
        connectTimeout: Constants.CONNECTION_TIMEOUT,
      ));
    }
  }
  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Constants.BASE_URL) {
        _dio.options.baseUrl = Constants.BASE_URL;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, params, {noTip = false}) async {
    Response response;
    print(12345);
    try {
      response = await _dio.get(api, queryParameters: params);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }
    return response;
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return new ResultData(
      errorResponse.statusMessage, false, errorResponse.statusCode);
}
