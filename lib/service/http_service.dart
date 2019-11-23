import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/index.dart';

Future request(url, { formData }) async {
    try {
      Response response;
      Dio dio = new Dio();
//      设置请求头
      dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
      // 处理一下不传参数的情况
      if( formData == null ) {
        response = await dio.post(servicePath[url]);
      }else {
        response = await dio.post(servicePath[url], data: formData);
      }

      if( response.statusCode == 200 ) {
        return response;
      }else {
        throw Exception('后端接口异常， 请检查测试代码和服务器运行情况');
      }
    }catch(e) {
      return print('error:::${e}');
    }
}