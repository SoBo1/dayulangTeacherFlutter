// ignore: file_names, import_of_legacy_library_into_null_safe
// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class ReturnData {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  late int code;
  late String msg;

  ReturnData(this.data, this.code, this.msg);
  factory ReturnData.fromJson(Map<String, dynamic> json) =>
      _$initResponseFromJson(json);
  Map<String, dynamic> toJson() => _$initWithjsonModel(this);
}

ReturnData _$initResponseFromJson(Map<String, dynamic> json) {
  return ReturnData(json['data'], json['code'], json['msg']);
}

Map<String, dynamic> _$initWithjsonModel(ReturnData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'msg': instance.msg,
    };
