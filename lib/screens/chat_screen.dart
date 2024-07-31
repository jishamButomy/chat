import 'package:chat_soket_test/provider/chat_provider.dart';
import 'package:chat_soket_test/screens/splasj_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_textstyle.dart';
import '../helper/constants.dart';
import '../helper/debounce.dart';
import '../helper/shared_preference.dart';
import '../main.dart';

class ChatScreen extends StatefulWidget {
  final int? id;

  const ChatScreen({super.key, this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatProvider>(context, listen: false).initLoading();
    loadStaus();
    super.initState();
  }

  loadStaus() async {
    socket.on("typing", (data) async {
      print("typing is ----$data");
      context.read<ChatProvider>().changeStatus(data);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<ChatProvider>(context, listen: false).initDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loader = context.watch<ChatProvider>().msgLoader;

    return Scaffold(
      backgroundColor: const Color(0xFFb141b),
      appBar: AppBar(
        backgroundColor: const Color(0xFFb161c),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            context
                .read<ChatProvider>()
                .leaveRoom(id: widget.id, context: context);
          },
        ),
        title: Column(
          children: [
            Text(
              context
                      .read<ChatProvider>()
                      .usersList
                      ?.firstWhere((element) => element.id == widget.id)
                      .username ??
                  '',
              style: CustomFontStyle().common(
                  fontFamily: "Manrope",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            widget.id == context.watch<ChatProvider>().senderId
                ? Text(
                    context.watch<ChatProvider>().typingStatus.toString(),
                    style: CustomFontStyle().common(
                        fontFamily: "Manrope",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<ChatProvider>(builder: (context, msg, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loader
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Flexible(
                      child: ListView.separated(
                          controller: msg.controller,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                msg.chatRoom!.messages![index].senderId !=
                                        widget.id
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      ScreenUtil().screenWidth /
                                                          1.8,
                                                  minWidth: 60),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF134D37),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(22),
                                                    topLeft:
                                                        Radius.circular(22),
                                                    bottomLeft:
                                                        Radius.circular(22),
                                                  )),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   "You",
                                                  //   style: TextStyle(
                                                  //       fontSize: 14.sp,
                                                  //       fontWeight:
                                                  //           FontWeight.w600,
                                                  //       color: Colors.white),
                                                  // ),
                                                  Text(
                                                    msg
                                                            .chatRoom
                                                            ?.messages![index]
                                                            .content ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                    : const SizedBox(),
                                msg.chatRoom!.messages![index].senderId ==
                                        widget.id
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      ScreenUtil().screenWidth /
                                                          1.8,
                                                  minWidth: 60),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF1F2C34),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(22),
                                                    topLeft:
                                                        Radius.circular(22),
                                                    bottomRight:
                                                        Radius.circular(22),
                                                  )),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    msg
                                                            .chatRoom
                                                            ?.messages![index]
                                                            .content ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                    : const SizedBox(),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: msg.chatRoom?.messages?.length ?? 0),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  focusNode: msg.focusNode,
                  onChanged: (val) {
                    msg.onTextChanged(val, context, widget.id!);
                  },
                  cursorColor: Colors.blue,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp),
                  controller: msg.msgCtrl,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      counter: const SizedBox.shrink(),
                      fillColor: Color(0xFF1f2c34),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      constraints: BoxConstraints(minHeight: 50.h),
                      hintText: "Type anything...",
                      hintStyle: CustomFontStyle().common(
                        color: const Color(0xFF97AAAA),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      suffixIconConstraints: BoxConstraints(maxHeight: 65.h),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          onTap: () async {
                            if (msg.msgCtrl!.text.isNotEmpty) {
                              msg.sendMsg(
                                  id: widget.id,
                                  context: context,
                                  txt: msg.msgCtrl!.text);
                              msg.msgCtrl!.clear();
                            }
                          },
                          child: const Icon(
                            Icons.send,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ))),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
