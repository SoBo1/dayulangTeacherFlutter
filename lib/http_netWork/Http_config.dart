// http_config.dart 文件中主要配置请求相关的一些公共配置

// 请求服务器地址
class Api {
  static getBanner() async {
    // return await HttpDYL().get('/api/auth/queryroles');
  }
}

const String baseUrl = 'https://test.dayulong.cn/napi';

// 请求连接
const Map urlPath = {
  'dylUrl_roleChange': '/api/auth/queryroles',
};

// content-type
// const Map contentType = {
//   'json': "application/json",
//   'form': "application/x-www-form-urlencoded"
// };
