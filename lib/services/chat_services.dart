import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../helper/constants.dart';
import '../helper/toast_util.dart';
import '../models/chat_users_model.dart';
import '../models/message_model.dart';
import 'network_helper.dart';

class ChatService {
  Future<List<ChatUserList>?> getUserList({
    required BuildContext context,
  }) async {
    Response? response;
    response = await DioNetworkHelpers().getRequest(
      '${baseurl}users',
    );

    if (response!.statusCode == 200 || response.statusCode == 202) {
      final List<dynamic> items = response.data;
      return items.map((json) => ChatUserList.fromJson(json)).toList();
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.data);
    }
  }

  Future login({
    required BuildContext context,
    required String? email,
    required String? password,
  }) async {
    Response? response;
    response = await DioNetworkHelpers().postRequest(
        header: {},
        url: '${baseurl}login',
        body: {"email": email, "password": password});

    if (response?.statusCode == 200 || response?.statusCode == 202) {
      return response?.data;
    } else {
      var error = response?.data;
      print(error.toString());
      ToastUtil.show(error['message']);

      debugPrint(response?.data);
      return null;
    }
  }

  Future sendOtp({
    required BuildContext context,
    required String? username,
    required String? email,
  }) async {
    Response? response;
    response = await DioNetworkHelpers().postRequest(
        url: '${baseurl}sendotp', body: {"username": username, "email": email});
    if (response?.statusCode == 200 || response?.statusCode == 202) {
      return response?.data;
    } else {
      var error = response?.data;
      print(error.toString());
      ToastUtil.show(error['message']);
      debugPrint(response?.data);
      return null;
    }
  }

  Future registerApp({required BuildContext context, var registerData}) async {
    Response? response;
    response = await DioNetworkHelpers()
        .postRequest(url: '${baseurl}appregister', body: registerData);
    print('-----$registerData');
    if (response?.statusCode == 200 || response?.statusCode == 202) {
      return response?.data;
    } else {
      var error = response?.data;
      print(error.toString());
      ToastUtil.show(error['message']);
      debugPrint(response?.data);
      return null;
    }
  }

  Future<MessagessList?> getMessageList(
      {required BuildContext context, required int id}) async {
    Response? response;
    response = await DioNetworkHelpers().getRequest(
      '${baseurl}messages/$id',
    );

    if (response!.statusCode == 200 || response.statusCode == 202) {
      return MessagessList.fromJson(response.data);
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.data);
    }
  }
}
