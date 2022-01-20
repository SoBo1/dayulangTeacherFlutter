// ignore: file_names, camel_case_types
class tokenManager {
  static final tokenManager _shareManange = tokenManager._internal();
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  late String access_token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IkZBQjNFRDFEOEJFNzgyMTdBNEI2MEI4NENBRTBEOUI0IiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2NDI2NTkwMjIsImV4cCI6MTY0Mjc0NTQyMiwiaXNzIjoiaHR0cDovL3Rlc3QuZGF5dWxvbmcuY24iLCJhdWQiOiJEYXl1bG9uZyIsImNsaWVudF9pZCI6IkRheXVsb25nX0FwcCIsInN1YiI6ImEzZmU2NDRlLWI4MTUtN2Y4Ni1iOTFiLTM5ZmE0YWQxMTIzMCIsImF1dGhfdGltZSI6MTY0MjY1OTAyMiwiaWRwIjoibG9jYWwiLCJuYW1lIjoi5bqX6ZW_5rGq6K-X5paHMSIsInBob25lX251bWJlciI6IjEzMTYyOTE5NzEyIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6IuW6l-mVv-axquivl-aWh0BkYXl1bG9uZy5jb20iLCJlbWFpbF92ZXJpZmllZCI6IkZhbHNlIiwiaWQiOiJhM2ZlNjQ0ZS1iODE1LTdmODYtYjkxYi0zOWZhNGFkMTEyMzAiLCJVc2VySWQiOiI4MDAwMDEiLCJyb2xlIjoi55u06JCl5bqX6ZW_IiwianRpIjoiNERGQTBBMDNDMkMxMjI5RTQ4MDRCMDM2QUI1QkI0NzYiLCJpYXQiOjE2NDI2NTkwMjIsInNjb3BlIjpbIkRheXVsb25nIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.jflaIBqLH4H7bpMi1yBHrq8MBxFQqrLIVmqoTH9qiYwlQZYU9S--kMaf-r8-1csNS-pVDy8W9wZFy6X48pDY4jthZ4YTMBWM9kUlJ4EmKNN-EoF3jL_RmZSOYfavv2K-qJQH_1e_QG5PNeC_t6roHzF3uuv-oD486WBlSgMQenFnznQ7pXHnpV40XDMKW0x42MMF5aS9t1DLyZR-vnTFb-8--f98tkpHq0eJEdjfrr8B3HrK3FnN7_5NVzQ1RwLrKYUjL2BjaNgVkVdpaD0TfzWM8eQZCOe6xTL5ijwnaxLRo73edj4MxtZPK3cWM9Ud8SqdLbALOkbdbGCKN6ZIGg";
  // ignore: non_constant_identifier_names
  late String refresh_token = "";
  // ignore: non_constant_identifier_names
  late String expires_in = "";
  late String roleID = "";

  factory tokenManager() => _shareManange;
  tokenManager._internal();

  // tokenManager(this.access_token, this.refresh_token, this.expires_in);
  // factory tokenManager.fromJson(Map<String, dynamic> json) =>
  //     _$initResponseFromJson(json);
  // Map<String, dynamic> toJson() => _$initWithjsonModel(this);
}

// tokenManager _$initResponseFromJson(Map<String, dynamic> json) {
//   return tokenManager(json['access_token'], json['refresh_token'], json['expires_in']);
// }

// Map<String, dynamic> _$initWithjsonModel(tokenManager instance) =>
//     <String, dynamic>{
//       'data': instance.access_token,
//       'code': instance.refresh_token,
//       'msg': instance.expires_in,
//     };
