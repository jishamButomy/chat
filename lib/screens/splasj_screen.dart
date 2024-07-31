import 'dart:async';
import 'dart:io';

import 'package:chat_soket_test/screens/users_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../helper/constants.dart';
import '../helper/shared_preference.dart';
import '../main.dart';
import '../provider/chat_provider.dart';
import 'chat_screen.dart';
import 'login.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

late io.Socket socket;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    connectSocket();
    super.initState();
    Timer(const Duration(seconds: 2), () {
      loadData();
    });
  }



  connectSocket() {
    socket.onConnect((data) => debugPrint('Connection Establish Successfully'));
    socket.onConnectError((data) => debugPrint("connection error: $data"));
    socket.onDisconnect((data) => debugPrint("socket server disconnected"));
    // socket.on("typing", (data) async {
    //   // int? id = await SharedPrefUtil.getInt(keyAccessId);
    //   print("typing is ----$data");
    //   // if (id != data['senderId']) {
    //   //   Provider.of<ChatProvider>(context, listen: false).receiveMsg(data);
    //   // }
    // });
  }

  loadData() async {
    final bool hasToken = await SharedPrefUtil.contains(keyAccessToken);
    loginUserId = await SharedPrefUtil.getInt(keyAccessId);

    if (hasToken) {
      String token;
      token = await SharedPrefUtil.getString(keyAccessToken);
      Provider.of<ChatProvider>(context,listen: false).registerSocket(token);
      Provider.of<ChatProvider>(context,listen: false).onlineUsers(token);





      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ChatUsersList()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ChatLogin()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          width: 125.w,
          height: 125.h,
          'assets/svg/app_icon.svg',
        ),
      ),
    );
  }
}
