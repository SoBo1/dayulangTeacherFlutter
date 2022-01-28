// ignore: file_names, camel_case_types
class tokenManager {
  static final tokenManager _shareManange = tokenManager._internal();
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  late String access_token = "";
  // ignore: non_constant_identifier_names
  // late String access_token  ="eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyRDlGQkQ1Q0JFNzI0NDRGMjlFMUQzREI5ODE2MTFEIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2NDMzNDk2NjQsImV4cCI6MTY0MzQzNjA2NCwiaXNzIjoiaHR0cDovL3Rlc3QuZGF5dWxvbmcuY24iLCJhdWQiOiJEYXl1bG9uZyIsImNsaWVudF9pZCI6IkRheXVsb25nX0FwcCIsInN1YiI6ImEzZmU2NDRlLWI4MTUtN2Y4Ni1iOTFiLTM5ZmE0YWQxMTIzMCIsImF1dGhfdGltZSI6MTY0MzM0OTY2NCwiaWRwIjoibG9jYWwiLCJuYW1lIjoi5bqX6ZW_5rGq6K-XIiwicGhvbmVfbnVtYmVyIjoiMTMxNjI5MTk3MTIiLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJGYWxzZSIsImVtYWlsIjoi5bqX6ZW_5rGq6K-X5paHQGRheXVsb25nLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJpZCI6ImEzZmU2NDRlLWI4MTUtN2Y4Ni1iOTFiLTM5ZmE0YWQxMTIzMCIsIlVzZXJJZCI6IjgwMDAwMSIsInJvbGUiOiLmgLvpg6jotKLliqEiLCJqdGkiOiIzOTFCRUMwNzg0OUJDRDk5RjVCOTUzRDc4RDNCRUZGNCIsImlhdCI6MTY0MzM0OTY2NCwic2NvcGUiOlsiRGF5dWxvbmciLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.lsL3fCDC7ok3_3koCqSlZlqBQh6oRQf7GmkgHaentoItSmWwZH1gOStTiCaAzjAiIi8hve6hBYVGP8kHx0gE9FCPUOaAr4JBWuSG18W_SVOrSAK--SR6M7NyfuCdHO7ClSyBuBrxYM35yxjrk0cE9x8-GSYvzuXI4SSe7ajbQUMHMaICAjeIf1qCI3qo_Yxacv6uQIz4YJS3gOjk6kucKV";
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
