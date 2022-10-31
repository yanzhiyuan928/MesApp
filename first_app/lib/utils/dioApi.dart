// ignore_for_file: unnecessary_new, avoid_print, duplicate_ignore, prefer_is_empty

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

enum Method { get, post }
const baseURL = "http://172.28.16.40:90/api/"; //域名地址
const logIn = baseURL + "System/PostLoginIn";
const getPlant = baseURL + "System/GetPlant";

Future sendRequest(String url, Method method, Map<String, dynamic> map) async {
  try {
    // ignore: avoid_print
    print("开始请求数据");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var type = method;
    switch (type) {
      case Method.get:
        print('开始使用get');
        //response = await dio.get(url);
        if (map.length == 0) {
          response = await dio.get(url);
        } else {
          response = await dio.get(url, queryParameters: map);
        }
        break;
      case Method.post:
        // ignore: avoid_print
        print('开始使用post');
        FormData formData = FormData.fromMap(map);
        response = await dio.post(url, data: formData);
        break;
    }
    // if (response.data .toString() != 'null') {
    //   print('收到返回信息==>' + response.data);
    // }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('error');
  }
}
