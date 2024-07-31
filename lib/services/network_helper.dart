import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../helper/constants.dart';
import '../helper/shared_preference.dart';
import '../helper/toast_util.dart';

class DioNetworkHelpers {
  var _dio = Dio();
  Future<Response?> getRequest(String? url,
      [Map<String, dynamic>? queryParameters]) async {
    late String token;
    final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);
    if (hasToken) {
      token = await SharedPrefUtil.getString(keyAccessToken);
    } else {
      token = "";
    }
    print('token is ---$token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    print('token is ---$token --------$headers');
    Response? result;
    try {
      result = await _dio.get(
          url!,
          queryParameters: queryParameters,
          options: Options(headers: headers)
      );
      debugPrint(
          "$url --- status:${result.statusCode}---body:$result------------headers--------${queryParameters}");
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
    } catch (e) {
      ToastUtil.show(e.toString());
    }
    return result;
  }

  Future<Response?> postRequest({
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    late String token;
    final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);
    if (hasToken) {
      token = await SharedPrefUtil.getString(keyAccessToken);
    } else {
      token = "";
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    Response? result;
    try {
      result = await _dio.post(url!,
          data: body, options: Options(headers: header ?? headers));
      debugPrint(
          "$url --- status:${result.statusCode}---body:$result------------headers--------${body}");
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
    } catch (e) {
      ToastUtil.show(e.toString());
    }

    return result;
  }

  Future<Response?> multipartPostRequest({
    String? url,
    FormData? formData,
    Map<String, String>? header,
  }) async {
    late String token;
    final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);
    if (hasToken) {
      token = await SharedPrefUtil.getString(keyAccessToken);
    } else {
      token = "";
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    Response? result;
    try {
      result = await _dio.post(url!,
          data: formData, options: Options(headers: header ?? headers));

      debugPrint(
          "$url --- status:${result.statusCode}---body:$result------------headers--------${formData}");
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
    } catch (e) {
      ToastUtil.show(e.toString());
    }
    return result;
  }

}