import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_widgets/custom_textstyle.dart';

class SnackBarUtil {
  static void show({String? title, String? message, BuildContext? context}) {
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message??'Yay! A SnackBar!',
        style: CustomFontStyle().common(
            fontFamily: "Manrope",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white),
      ),
      duration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 30,
        left: 10,
        right: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
  }
}
