import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_flutter/DYL_userManager.dart';
import 'package:my_flutter/TokenManager/tokenManager.dart';
import 'package:my_flutter/http_netWork/Http_config.dart';
import 'package:my_flutter/http_netWork/http_loading.dart';
import 'ReturnData.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpDYL {
  // 单例模式
  static final HttpDYL _instance = HttpDYL._internal();
  factory HttpDYL() => _instance;
  HttpDYL._internal() {
    init();
  }

  Dio? _dio;

  // 初始化请求配置
  init() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Api().baseUrl,
        connectTimeout: 5000,
        headers: {
          "DEVICE": "IOS",
          "terminal": "3",
          "VERSION": "app-version",
          // "device-id": "",
          "app-code": "Dayulong_Merchant",
          // "environment": "",
          // ignore: equal_keys_in_map
          "environment": "sit",
          "Authorization": "Bearer " + tokenManager().access_token,
          'Content-Type': 'application/x-www-form-urlencoded',
        });
    _dio = Dio(baseOptions);
  }

  // 请求(默认post)
  // ignore: non_constant_identifier_names
  Future<ReturnData> getNetWork(String url,
      {String method = "GET",
      bool isModel = true,
      required Map<String, dynamic> params}) async {
    Options options = Options(method: method);
    try {
      final result =
          await _dio?.request(url, queryParameters: params, options: options);
      ReturnData messageData = ReturnData.fromJson(result?.data);
      return messageData;
    } on DioError catch (error) {
      altErrorMessage(error.message);
      LoadingUtils.dismiss();
      rethrow;
    }
  }

  Future<ReturnData> postNetWork(String url,
      {String method = "POST",
      bool isModel = true,
      required Map<String, dynamic> params}) async {
    // Options options = Options(method: method);
    Response? response;
    try {
      response = await _dio?.post(url, data: params);

      ReturnData messageData = ReturnData.fromJson(response?.data);
      return messageData;
    } on DioError catch (error) {
      altErrorMessage(error.message);
      LoadingUtils.dismiss();
      rethrow;
    }
  }

  Future<Response?> postNetWorkNomodel(String url,
      {String method = "POST",
      bool isModel = true,
      required Map<String, dynamic> params}) async {
    // Options options = Options(method: method);
    Response? response;
    try {
      response = await _dio?.post(url, data: params);
      return response;
    } on DioError catch (error) {
      altErrorMessage(error.message);
      LoadingUtils.dismiss();
      rethrow;
    }
  }

  altErrorMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        fontSize: 16.0);
  }
}
