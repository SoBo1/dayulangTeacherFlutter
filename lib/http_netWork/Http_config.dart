// http_config.dart 文件中主要配置请求相关的一些公共配置
// 请求连接

// content-type
// const Map contentType = {
//   'json': "application/json",
//   'form': "application/x-www-form-urlencoded"
// };
class Api {
  static final Api _shareManange = Api._internal();

  final isProd = const bool.fromEnvironment('dart.vm.product');
  late String baseUrl = 'https://test.dayulong.cn/napi';
  // late String baseUrl = 'https://www.dayulong.cn';

  factory Api() => _shareManange;
  Api._internal();
}

const Map urlPath = {
  'dylUrl_roleChange': '/api/auth/queryroles',
};
