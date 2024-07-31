import 'dart:async';

import 'package:chat_soket_test/provider/chat_provider.dart';
import 'package:chat_soket_test/screens/login.dart';
import 'package:chat_soket_test/screens/profile_screen.dart';
import 'package:chat_soket_test/screens/splasj_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../common_widgets/custom_textstyle.dart';
import '../helper/constants.dart';
import '../helper/shared_preference.dart';
import '../helper/snackbar_util.dart';

class ChatUsersList extends StatefulWidget {
  const ChatUsersList({super.key});

  @override
  State<ChatUsersList> createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatProvider>(context, listen: false)
        .fetchUserList(context: context);
    loadid();
    super.initState();
  }

  loadid() async {
    String token;
    token = await SharedPrefUtil.getString(keyAccessToken);
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      Provider.of<ChatProvider>(context, listen: false).onlineUsers(token);
    });

    socket.on("message", (data) async {
      int? id = await SharedPrefUtil.getInt(keyAccessId);
      print('id is----$id');
      print("messagess----$data");
      if (id != data['senderId']) {
        Provider.of<ChatProvider>(context, listen: false).receiveMsg(data);
      }
    });
    socket.on("notification", (data) async {
      print("messagess----$data");
      // if (id != data['senderId']) {
      SnackBarUtil.show(context: context, message: data);
      // Provider.of<ChatProvider>(context, listen: false)
      //     .addnewmassNotification();
      // }
    });
    socket.on("onlineusers", (data) async {
      print("onlineusers- are ---$data");
      Provider.of<ChatProvider>(context, listen: false).addonlineusers(data);
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFb141b),
      appBar: AppBar(
        toolbarHeight: 80,
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFb141b),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                SnackBarUtil.show(context: context);
              },
              child: Text(
                'Chat Wave',
                style: CustomFontStyle().common(
                    fontFamily: "Nothing",
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            Text(
              Provider.of<ChatProvider>(context, listen: true)
                      .usersList
                      ?.firstWhere((e) => e.id == loginUserId)
                      .username ??
                  '',
              style: CustomFontStyle().common(
                  fontFamily: "Manrope",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
            child: Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        Provider.of<ChatProvider>(context, listen: true)
                                .usersList
                                ?.firstWhere((e) => e.id == loginUserId)
                                .imageUrl ??
                            ''),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                await SharedPrefUtil.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ChatLogin()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<ChatProvider>(builder: (context, users, _) {
        return users.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                separatorBuilder: (context, index) =>
                    users.usersList![index].id != loginUserId
                        ? const Divider(
                            thickness: 0.3,
                          )
                        : const SizedBox(),
                itemBuilder: (context, index) {
                  return users.usersList![index].id != loginUserId
                      ? ListTile(
                          onTap: () {
                            users.joinRoom(
                                context: context,
                                id: users.usersList![index].id!);
                            // socket.on("message", (data) {
                            //   print("messagess----$data");
                            //   if (users.usersList![index].id == data['senderId']) {
                            //     context.read<ChatProvider>().receiveMsg(data);
                            //   }
                            // });
                          },
                          leading: Stack(
                            children: [
                              Container(
                                width: 45.w,
                                height: 45.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        users.usersList![index].imageUrl ?? '',
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              users.onlineId
                                      .contains(users.usersList![index].id)
                                  ? const Positioned(
                                      right: 2,
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          title: Text(
                            users.usersList![index].id == loginUserId
                                ? "You"
                                : '${users.usersList![index].username}---${users.usersList![index].id}',
                            style: CustomFontStyle().common(
                                fontFamily: "Manrope",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          subtitle: users.usersList![index].lastMessage != null
                              ? Text(
                                  '${users.usersList![index].lastMessage?.type == 'Received' ? "${users.usersList![index].username}" : "you"}: ${users.usersList![index].lastMessage?.message ?? ''}',
                                  style: CustomFontStyle().common(
                                      fontFamily: "Manrope",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                )
                              : const SizedBox(),
                        )
                      : const SizedBox();
                },
                itemCount: users.usersList?.length ?? 0,
              );
      }),
    );
  }
}
