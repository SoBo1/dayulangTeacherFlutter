import 'package:flutter/services.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

//与app端定义一样 不可随便变更
// ignore: non_constant_identifier_names
String OCPush_FlutterBrdgingDYL = "buildBrdgingDYLPull";
// ignore: non_constant_identifier_names
String OCPull_FlutterBrdgingDYL = "buildBrdgingDYLPush";

String appRoleRefreshToken = 'roleRefreshTokenFlutter';
String refreshUsermanager = 'refreshUsermanager';
String refreshBaseConfig = 'flutterBaseUrlConfig';
//给app端传值
// ignore: non_constant_identifier_names
void pushApp_Brdging(String key, {params}) async {
  MethodChannel platform = MethodChannel(OCPull_FlutterBrdgingDYL);

  String batteryLevel;
  try {
    final int result = await platform.invokeMethod(key, params);
    batteryLevel = 'Battery level at $result % .';
  } on PlatformException catch (e) {
    batteryLevel = "Failed to get battery level: '${e.message}'.";
  }
}

//app给flutter传值
// ignore: non_constant_identifier_names
Future<dynamic> pullApp_Brdging(String key, {params}) async {
  MethodChannel platform = MethodChannel(OCPull_FlutterBrdgingDYL);

  platform.setMethodCallHandler((MethodCall call) {
    print('brdging = ${call.method}+         ${call.arguments}');
    if (call.method == key) {
      dynamic arguments = call.arguments;
      Fluttertoast.showToast(
        msg: 'refreshUsermanager=====$arguments',
      );
      return arguments;
    } else {
      dynamic nullStr;
      return nullStr;
    }
  });
}
