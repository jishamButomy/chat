import 'package:chat_soket_test/provider/chat_provider.dart';
import 'package:chat_soket_test/screens/splasj_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'helper/constants.dart';

// late io.Socket socket;
void main()async {
  socket =
      io.io(baseurl, io.OptionBuilder().setTransports(['websocket']).build());
  // connectSocket();
  runApp(const MyApp());
}
// connectSocket() {
//   socket.onConnect((data) => debugPrint('Connection Establish Successfully'));
//   socket.onConnectError((data) => debugPrint("connection error: $data"));
//   socket.onDisconnect((data) => debugPrint("socket server disconnected"));
//   socket.on("message", (data) {
//     print("messagess----$data");
//
//     // if (users.usersList![index].id == data['senderId']) {
//     //   context?.read<ChatProvider>().receiveMsg(data);
//     // }
//
//   });
// }


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          // ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
          ChangeNotifierProvider(create: (context) => ChatProvider()),
        ],
        child: MaterialApp(
          title: 'TaskBerry',
          theme: ThemeData(
              ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
