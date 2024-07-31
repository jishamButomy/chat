import 'package:chat_soket_test/provider/chat_provider.dart';
import 'package:chat_soket_test/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_textfield.dart';
import '../common_widgets/custom_textstyle.dart';
import '../helper/validation.dart';

class ChatLogin extends StatefulWidget {
  const ChatLogin({super.key});

  @override
  State<ChatLogin> createState() => _ChatLoginState();
}

class _ChatLoginState extends State<ChatLogin> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController? emailCtrl;
  late TextEditingController? passwordCtrl;
  @override
  void initState() {
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailCtrl!.dispose();
    passwordCtrl!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height:
                    ScreenUtil().screenHeight - ScreenUtil().statusBarHeight,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      // vertical: 10
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ScreenUtil().screenHeight / 6,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Chat Wave",
                              style: CustomFontStyle().common(
                                  fontFamily: "Manrope",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Text(
                            "",
                            style: CustomFontStyle().common(
                                fontFamily: "Manrope",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            hintText: 'Enter Your Email',
                            controller: emailCtrl,
                            validator: (value) {
                              return ValidationUtil().emailValidation(
                                  'login.emailController.text');
                            },
                          ),
                          Text(
                            "",
                            style: CustomFontStyle().common(
                                fontFamily: "Manrope",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            hintText: "Enter Your Password",
                            isPasswordType: true,
                            maxLine: 1,
                            controller: passwordCtrl,
                            // validator: (value) {
                            //   return ValidationUtil(context).validatePassword(
                            //       login.passwordController.text);
                            // },
                          ),
                          // const Spacer(),
                          SizedBox(
                            height: 25.h,
                          ),
                          CustomButton(
                            text: "Login",
                            isLoading:
                                Provider.of<ChatProvider>(context, listen: true)
                                    .isLoading,
                            onPress: () {
                              Provider.of<ChatProvider>(context, listen: false)
                                  .login(
                                      email: emailCtrl?.text.trim(),
                                      context: context,
                                      password: passwordCtrl?.text.trim());
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Are you a new user? ",
                                style: CustomFontStyle().common(
                                    fontFamily: "Manrope",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ));
                                },
                                child: Text(
                                  " SignUp",
                                  style: CustomFontStyle().common(
                                      fontFamily: "Manrope",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )

        // Scaffold(
        //   backgroundColor: Colors.white,
        //   body: Padding(
        //     padding: EdgeInsets.only(
        //         top: ScreenUtil().statusBarHeight * 4,
        //         left: 15,
        //         right: 15,
        //         bottom: 5),
        //     child:
        //   ),
        // ),
        );
  }
}
