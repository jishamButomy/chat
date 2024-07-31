import 'package:chat_soket_test/common_widgets/custom_button.dart';
import 'package:chat_soket_test/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class EnterOtp extends StatelessWidget {
  const EnterOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, otp, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: OtpTextField(
              keyboardType: TextInputType.number,
              contentPadding: EdgeInsets.zero,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              numberOfFields: 4,
              borderColor: Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                print(verificationCode);
                otp.registerModel?.otp = int.parse(verificationCode);
                otp.notifyListeners();
              }, // end onSubmit
            ),
          ),
          CustomButton(
            isLoading: otp.isLoading,
            text: 'Register',
            onPress: () {
              print(otp.registerModel?.toJson());
              otp.register(context: context);
            },
          )
        ],
      );
    });
  }
}
