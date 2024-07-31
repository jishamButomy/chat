import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_textfield.dart';
import '../common_widgets/custom_textstyle.dart';
import '../helper/validation.dart';
import '../models/regiter_model.dart';
import '../provider/chat_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatProvider>(context, listen: false).signUpScreenLoading();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<ChatProvider>(context, listen: false).signUpScreenDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: ScreenUtil().screenHeight - ScreenUtil().statusBarHeight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  // vertical: 10
                ),
                child: Consumer<ChatProvider>(builder: (context, signUp, _) {
                  return Form(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chat Wave",
                                style: CustomFontStyle().common(
                                    fontFamily: "Manrope",
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                "Sign Up",
                                style: CustomFontStyle().common(
                                    fontFamily: "Manrope",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomTextField(
                          hintText: 'Enter Your Username',
                          controller: signUp.userNameCtrl,
                          onChanged: (vale) {
                            signUp.registerModel?.username = vale;
                            signUp.notifyListeners();
                          },
                          validator: (value) {
                            return ValidationUtil()
                                .emailValidation('login.emailController.text');
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
                          hintText: 'Enter Your Email',
                          controller: signUp.userEmailCtrl,
                          onChanged: (vale) {
                            signUp.registerModel?.email = vale;
                            signUp.notifyListeners();
                          },
                          validator: (value) {
                            return ValidationUtil()
                                .emailValidation('login.emailController.text');
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
                          controller: signUp.userPasswordCtrl,
                          onChanged: (vale) {
                            signUp.registerModel?.password = vale;
                            signUp.notifyListeners();
                          },
                          // validator: (value) {
                          //   return ValidationUtil(context).validatePassword(
                          //       login.passwordController.text);
                          // },
                        ),
                        // const Spacer(),
                        SizedBox(
                          height: 25.h,
                        ),
                        Consumer<ChatProvider>(builder: (context, signUp, _) {
                          return CustomButton(
                            text: "Send OTP",
                            isLoading: signUp.isLoading,
                            onPress: ((signUp.registerModel?.username == ''
                                        ? false
                                        : true) &&
                                    (signUp.registerModel?.password == ''
                                        ? false
                                        : true) &&
                                    (signUp.registerModel?.email == ''
                                        ? false
                                        : true))
                                ? () {

                                   signUp
                                        .sendOtp(
                                        context: context,);
                                  }
                                : null,
                          );
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: CustomFontStyle().common(
                                  fontFamily: "Manrope",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                " Login",
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
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
