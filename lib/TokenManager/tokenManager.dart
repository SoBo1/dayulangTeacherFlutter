// ignore: file_names, camel_case_types
class tokenManager {
  static final tokenManager _shareManange = tokenManager._internal();
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_namessource ~/.bash_profile
  // late String access_token = "";
  late String access_token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IkM5RDZCMzJCNURBRkI5QkVCRkNGMkYwODhEOTgxMjk1IiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2NTMzOTA3MzAsImV4cCI6MTY1MzQ3NzEzMCwiaXNzIjoiaHR0cDovL3Rlc3QuZGF5dWxvbmcuY24iLCJhdWQiOiJEYXl1bG9uZyIsImNsaWVudF9pZCI6IkRheXVsb25nX0FwcCIsInN1YiI6ImEzZmU2NDRlLWI4MTUtN2Y4Ni1iOTFiLTM5ZmE0YWQxMTIzMCIsImF1dGhfdGltZSI6MTY1MzM5MDczMCwiaWRwIjoibG9jYWwiLCJuYW1lIjoi5bqX6ZW_5rGq6K-XMTIzIiwicGhvbmVfbnVtYmVyIjoiMTMxNjI5MTk3MTIiLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJGYWxzZSIsImVtYWlsIjoi5bqX6ZW_5rGq6K-X5paHQGRheXVsb25nLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJpZCI6ImEzZmU2NDRlLWI4MTUtN2Y4Ni1iOTFiLTM5ZmE0YWQxMTIzMCIsIlVzZXJJZCI6IjgwMDAwMSIsInJvbGUiOiLliqnnkIYiLCJqdGkiOiJBQjA4MDI1NTgzOTM2MTYyRkVBNkQzOTc0RTRCQTlFQyIsImlhdCI6MTY1MzM5MDczMCwic2NvcGUiOlsiRGF5dWxvbmciLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.l1BH-beOtheVApbq5onnitMf18dNNB8531eUh9z3kQgI1kzKYkDJUjrvTilabWbAyEafZZiZlvx6JYyDHzZPeoxLSlfVgp3ZwSj7VIR-ES2iv4lD9Ijx1rmFljjjTvyHSvzA7FX2ygtbckKoVwDxlxhBuX71vF4SNynoJ_Zkif0rLaWDrhVvX9dXKbysRCuMp8edsD8KPYzz4xABCTE5FsTCDR8YgDClvh4MlJcl9uH0U5H9vS7y_Bova1ylLkQjU7ijfqSUqxkNMmajg5O7zQnxSmaUFrErP3mPgp64w4xUq0owIP37tCPkFMqePVGQK4TdnYGUlRUoCQjYsMzz3Q";
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
