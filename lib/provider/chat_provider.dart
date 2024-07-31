import 'dart:async';
import 'dart:convert';

import 'package:chat_soket_test/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common_widgets/custom_textstyle.dart';
import '../helper/Dialogbox_util.dart';
import '../helper/constants.dart';
import '../helper/shared_preference.dart';
import '../helper/toast_util.dart';
import '../main.dart';
import '../models/chat_users_model.dart';
import '../models/message_model.dart';
import '../models/regiter_model.dart';
import '../screens/enter_otp.dart';
import '../screens/login.dart';
import '../screens/splasj_screen.dart';
import '../screens/users_list_screen.dart';
import '../services/chat_services.dart';

class ChatProvider with ChangeNotifier {
  bool isLoading = false;

  login({
    required BuildContext context,
    required String? email,
    required String? password,
  }) async {
    isLoading = true;
    notifyListeners();
    var responce;
    responce = await ChatService().login(
      context: context,
      email: email,
      password: password,
    );
    print('[------${responce}');
    print('[------${responce}');
    print('[------${responce}');

    if (responce['status']) {
      var token =
          await SharedPrefUtil.writeString(keyAccessToken, responce['token']);
      await SharedPrefUtil.writeInt(keyAccessId, responce['userId']);
      loginUserId = responce['userId'];
      if (token) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatUsersList()));
        registerSocket(responce['token']);
        onlineUsers(responce['token']);
      }
      print('the token is---$token');
    } else {
      ToastUtil.show(responce['message']);
    }

    isLoading = false;
    notifyListeners();
  }

  sendOtp({
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    var responce;
    responce = await ChatService().sendOtp(
        context: context,
        email: registerModel?.email,
        username: registerModel?.username);
    print('[------${responce}');
    if (responce['status']) {
      ToastUtil.show(responce['message']);
      dialogBox(
          context: context,
          title: Text(
            "${responce['message']}",
            textAlign: TextAlign.center,
            style: CustomFontStyle().common(
              color: const Color(0xFF1C1C1C),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: EnterOtp());
    } else {
      ToastUtil.show(responce['message']);
    }
    isLoading = false;
    notifyListeners();
  }

  register({
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    var responce;
    responce = await ChatService()
        .registerApp(context: context, registerData: registerModel?.toJson());
    print('[------${responce}');
    if (responce['status']) {
      ToastUtil.show(responce['message']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ChatLogin()),
          (Route<dynamic> route) => false);
    } else {
      ToastUtil.show(responce['message']);
    }
    isLoading = false;
    notifyListeners();
  }

  List<ChatUserList>? usersList;

  List onlineId = [];
  fetchUserList({
    required BuildContext context,
  }) async {
    isLoading = true;
    usersList = (await ChatService().getUserList(
      context: context,
    ))!;
    print('----${jsonEncode(usersList)}');
    isLoading = false;
    notifyListeners();
  }

  bool msgLoader = false;
  fetchMessageList({required BuildContext context, required int id}) async {
    msgLoader = true;
    notifyListeners();
    chatRoom = await ChatService().getMessageList(context: context, id: id);
    print('----${jsonEncode(usersList)}');

    msgLoader = false;
    notifyListeners();
  }

  // addnewmassNotification() {
  //   ChatUserList newmsg;
  //   newmsg = ChatUserList(
  //     id: 10,w
  //     username: 'testing',
  //   );
  //   usersList?.insert(0, newmsg);
  //   notifyListeners();
  // }

  late TextEditingController? msgCtrl;
  ScrollController controller = ScrollController();
  MessagessList? chatRoom;

  joinRoom({int? id, BuildContext? context}) async {
    String token;
    token = await SharedPrefUtil.getString(keyAccessToken);
    Map<String, dynamic> data = {
      'token': token,
      'receiverId': id!,
    };
    print('$data');
    socket.emit(
      "joinRoom",
      [data],
    );

    Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            id: id,
          ),
        ));
    await fetchMessageList(context: context, id: id);

    notifyListeners();
  }

  sendMsg({String? txt, int? id, BuildContext? context}) async {
    String token;
    token = await SharedPrefUtil.getString(keyAccessToken);
    Map<String, dynamic> data = {
      'token': token,
      'receiverId': id,
      'content': txt
    };
    socket.emit("message", [data]);
    chatRoom?.messages?.add(Messages(
      content: txt,
      receiverId: id,
    ));
    controller.animateTo(
      controller.position.maxScrollExtent + 70,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  receiveMsg(var data) {
    // print('dgxf----$data---');
    chatRoom?.messages?.add(Messages.fromJson(data));
    controller.animateTo(
      controller.position.maxScrollExtent + 50,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  leaveRoom({int? id, BuildContext? context}) async {
    String token;
    token = await SharedPrefUtil.getString(keyAccessToken);
    Map<String, dynamic> data = {
      'token': token,
      'receiverId': id!,
    };
    print('data isss----$data');
    socket.emit(
      "leaveRoom",
      [data],
    );

    Navigator.pop(context!);
    notifyListeners();
  }

  registerSocket(String token) async {
    Map<String, dynamic> data = {
      'token': token,
    };
    print('data isss----$data');
    socket.emit(
      "register",
      [token],
    );
  }

  onlineUsers(String token) async {
    print('data isss----$token');
    socket.emit(
      "onlineusers",
      [token],
    );
  }

  addonlineusers(var data) {
    print('id is----- $data');
    onlineId = data;
    notifyListeners();
  }

  void scrollDown() {
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  late FocusNode focusNode;
  bool isTyping = false;

  initLoading() {
    typingStatus = '';
    msgCtrl = TextEditingController();
    focusNode = FocusNode();
  }

  initDispose() {
    // msgCtrl!.removeListener(handleTyping);
    // focusNode.removeListener(handleFocusChange);
    msgCtrl!.dispose();
    focusNode.dispose();
    debounce?.cancel();
  }

  void handleTyping() {
    if (msgCtrl!.text.isNotEmpty && focusNode.hasFocus) {
      isTyping = true;
      notifyListeners();
    } else {
      isTyping = false;
    }
  }

  void handleFocusChange() {
    if (!focusNode.hasFocus) {
      isTyping = false;
    }
  }

  typingOrNot({int? receiverId, BuildContext? context}) async {
    String token;
    token = await SharedPrefUtil.getString(keyAccessToken);
    Map<String, dynamic> data = {
      'token': token,
      'receiverId': receiverId,
    };
    socket.emit("typing", [data]);
  }

  Timer? debounce;

  String? typingStatus;

  void onTextChanged(String text, BuildContext context, int id) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      typingOrNot(context: context, receiverId: id);
    });
    notifyListeners();
    debounce = Timer(const Duration(milliseconds: 2000), () {
      typingStatus = '';
      print('-status is--$typingStatus');
      notifyListeners();
    });
  }

  int? senderId;

  changeStatus(var data) {
    typingStatus = data['status'];
    senderId = data['senderId'];
    notifyListeners();
    debounce = Timer(const Duration(milliseconds: 2000), () {
      typingStatus = '';
      senderId = null;
      print('-status is--$typingStatus');
      notifyListeners();
    });
  }

  RegisterModel? registerModel;
  late TextEditingController? userNameCtrl;
  late TextEditingController? userEmailCtrl;
  late TextEditingController? userPasswordCtrl;

  signUpScreenLoading() {
    print('lodfr');
    registerModel =
        RegisterModel(username: '', password: '', email: '', otp: null);
    userNameCtrl = TextEditingController();
    userEmailCtrl = TextEditingController();
    userPasswordCtrl = TextEditingController();
  }

  signUpScreenDispose() {
    userNameCtrl!.dispose();
    userEmailCtrl!.dispose();
    userPasswordCtrl!.dispose();
  }
}
