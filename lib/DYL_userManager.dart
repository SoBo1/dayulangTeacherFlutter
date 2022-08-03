// ignore: file_names
class UserManager {
  static final UserManager _shareManange = UserManager._internal();
  // late String userId = '';
  // late String teacherId = '';
  // late String phoneNumber = '';
  late String userId = "a3fe644e-b815-7f86-b91b-39fa4ad11230";
  late String teacherId = "b4377b7d-ea3c-7c2a-1219-39fe1d13626d";
  late String phoneNumber = '13162919712'; //13162919712

  late String userSig = '';
  late String passwordHash = '';
  late String headPictureUrl = '';
  late String backGroundPictureUrl = '';
  late String nickName = ''; //店长汪诗文
  late String autograph = '';
  late String shopId;

  late int sex;
  late int age;

  late String teacherHeadPictureUrl = '';
  late String teacherBackGroundPictureUrl = '';
  late String teacherNickName = '';
  late String type = '';

  late int fishNum;
  late int fishboneNum;
  late int dayulongNumber;
  late int isShopOwner;

  late String phoneId = ''; //13162919712
  // late String token =
  //     "eyJhbGciOiJSUzI1NiIsImtpZCI6IkQxRkU4OEREMERDOTcyNjM3RkZBQzdGNTkwMkI0MUNBIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2NDE1NDcyNjksImV4cCI6MTY0MTYzMzY2OSwiaXNzIjoiaHR0cDovL3Rlc3QuZGF5dWxvbmcuY24iLCJhdWQiOiJEYXl1bG9uZyIsImNsaWVudF9pZCI6IkRheXVsb25nX0FwcCIsInN1YiI6ImEzZmU2NDRlLWI4MTUtN2Y4Ni1iOTFiLTM5ZmE0YWQxMTIzMCIsImF1dGhfdGltZSI6MTY0MTU0NzI2OSwiaWRwIjoibG9jYWwiLCJuYW1lIjoi5bqX6ZW_5rGq6K-X5paHMSIsInBob25lX251bWJlciI6IjEzMTYyOTE5NzEyIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6IuW6l-mVv-axquivl-aWh0BkYXl1bG9uZy5jb20iLCJlbWFpbF92ZXJpZmllZCI6IkZhbHNlIiwiaWQiOiJhM2ZlNjQ0ZS1iODE1LTdmODYtYjkxYi0zOWZhNGFkMTEyMzAiLCJVc2VySWQiOiI4MDAwMDEiLCJyb2xlIjpbIuebtOiQpeW6l-mVvyIsIuaAu-mDqOi0ouWKoSJdLCJqdGkiOiIzMjg5REMwRjk1MTIxRjg5MjFBNTk4NTNCRUQyQzA4RCIsImlhdCI6MTY0MTU0NzI2OSwic2NvcGUiOlsiRGF5dWxvbmciLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.bR0S6o-onimSUvLgy2N7CqmBUX6spL338WFr2ThU4Tux-Xmrxzm5MsJq1_0TM1AVCsM0WW0zZlMICIWCcstf_5v3Kk9QTWrOIY6ifTaxoDFupoLMJIMrUjTD2NbYpbapCcuS5HNjro_Hx3xWLu0pAydcrwPpqdXVI1l3RQh5fqIJxnUM5GMgNTOOIh";
  // Use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class.
  // For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype.
  factory UserManager() => _shareManange;

  UserManager._internal();
}
// class UserManagerModel {

//    // private constructor

//   // ignore: prefer_typing_uninitialized_variables
//   String userId;
//   String teacherId;
//   String userSig;
//   String phoneNumber;
//   String passwordHash;
//   String headPictureUrl;
//   String backGroundPictureUrl;
//   String nickName;
//   String autograph;
//   String shopId;

//   late int sex;
//   late int age;

//   String teacherHeadPictureUrl;
//   String teacherBackGroundPictureUrl;
//   String teacherNickName;
//   String type;

//   late int fishNum;
//   late int fishboneNum;
//   late int dayulongNumber;
//   late int isShopOwner;

//   String phoneId;

//   UserManagerModel(
//       this.userId,
//       this.teacherId,
//       this.userSig,
//       this.phoneNumber,
//       this.passwordHash,
//       this.headPictureUrl,
//       this.backGroundPictureUrl,
//       this.nickName,
//       this.autograph,
//       this.shopId,
//       this.sex,
//       this.age,
//       this.teacherHeadPictureUrl,
//       this.teacherBackGroundPictureUrl,
//       this.teacherNickName,
//       this.type,
//       this.fishNum,
//       this.fishboneNum,
//       this.dayulongNumber,
//       this.isShopOwner,
//       this.phoneId);
//   factory UserManagerModel.fromJson(Map<String, dynamic> json) =>
//       _$initResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$initWithjsonModel(this);
// }

// UserManager _$initResponseFromJson(Map<String, dynamic> json) {
//   return UserManagerModel(
//       json['userId'],
//       json['teacherId'],
//       json['userSig'],
//       json['phoneNumber'],
//       json['passwordHash'],
//       json['headPictureUrl'],
//       json['backGroundPictureUrl'],
//       json['nickName'],
//       json['autograph'],
//       json['shopId'],
//       json['sex'],
//       json['age'],
//       json['teacherHeadPictureUrl'],
//       json['teacherBackGroundPictureUrl'],
//       json['teacherNickName'],
//       json['type'],
//       json['fishNum'],
//       json['fishboneNum'],
//       json['dayulongNumber'],
//       json['isShopOwner'],
//       json['phoneId']);
// }

// Map<String, dynamic> _$initWithjsonModel(UserManagerModel instance) =>
//     <String, dynamic>{
//       'data': instance.data,
//       'code': instance.code,
//       'msg': instance.msg,
//     };
