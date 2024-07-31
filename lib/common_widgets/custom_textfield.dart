import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onTapSuffix;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool isPasswordType;
  final int? maxLength;
  final int? maxLine;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final bool readonly;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final bool filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final String? sufixText;
  final InputBorder? borderside;
  const CustomTextField(
      {super.key,
      this.controller,
      this.onSaved,
      this.onTap,
      this.onChanged,
      this.onTapSuffix,
      this.hintText,
      this.keyboardType,
      this.hintStyle,
      this.maxLine,
      this.validator,
      this.suffixIcon,
      this.focusNode,
      this.prefixIcon,
      this.sufixText,
      this.isPasswordType = false,
      this.readonly = false,
      this.maxLength,
      this.borderside,
      this.fillColor = Colors.white,
      this.filled = true});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      // scrollPadding:widget.scrolling??EdgeInsets.zero ,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      readOnly: widget.readonly,
      focusNode: widget.focusNode,
      style: TextStyle(
          fontFamily: "Manrope",
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 16.sp),
      maxLength: widget.maxLength,
      maxLines: widget.maxLine ?? 1,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.isPasswordType ? _obscureText : false,
      decoration: InputDecoration(
          errorMaxLines: 4,
          counter: const SizedBox.shrink(),
          fillColor: widget.fillColor,
          filled: widget.filled ? true : false,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          constraints: BoxConstraints(minHeight: 50.h),
          hintText: widget.hintText,
          suffixStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
          ),
          hintStyle: widget.hintStyle ??
              TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
          suffix: InkWell(
              onTap: widget.onTapSuffix, child: Text(widget.sufixText ?? "")),
          suffixIconConstraints: BoxConstraints(maxHeight: 65.h),
          prefixIcon: widget.prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: widget.suffixIcon ??
                (widget.isPasswordType
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFFB5B5B5),
                        ),
                      )
                    : null),
          ),
          focusedBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE1E8F2))),
          errorBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE1E8F2))),
          enabledBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0XFFD9D9D9),
                  ))),
    );
  }
}
