import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_textfield.dart';

class Register extends StatelessWidget {
  final String heading;
  final Widget answer;

  Register.text({
    super.key,
    String? hintText,
    int? maxLine,
    int? maxLength,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    bool readonly = false,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
    TextEditingController? controller,
    String? Function(String?)? validator,
    required this.heading,
    TextStyle? hintStyle,
  }) : answer = CustomTextField(
          onSaved: onSaved,
          controller: controller,
          onChanged: onChanged,
          hintText: hintText,
          maxLength: maxLength,
          maxLine: maxLine ?? 1,
          validator: validator,
          keyboardType: keyboardType,
          focusNode: focusNode,
          readonly: readonly,
          hintStyle: hintStyle,
        );

  Register.dropDown(
      {super.key,
      required this.heading,
      Color? fillColor,
      required BuildContext context,
      String? value,
      String? hint,
      String? Function(String?)? validator,
      void Function(String?)? onChanged,
      var items})
      : answer = DropdownButtonFormField(
          isExpanded: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Colors.white,
          decoration: InputDecoration(
              counter: const SizedBox.shrink(),
              fillColor: fillColor ?? const Color(0xFFF5F5F5),
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              constraints: BoxConstraints(minHeight: 65.h),
              suffixIconConstraints: BoxConstraints(maxHeight: 65.h),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD9D9D9),
                  ))),
          hint: Text(
            hint ?? "",
            style: TextStyle(
              color: const Color(0xFFCACACA),
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
          ),
          value: value,
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 24.sp,
            color: Colors.green,
          ),
          items: items,
          onChanged: onChanged,
        );

  Register.radioBtn(
      {super.key,
      required this.heading,
      Color? activeColor,
      FontWeight? font,
      Axis scrollDirection = Axis.vertical,
      required List value,
      List? valueNames,
      required var groupValue,
      required void Function(dynamic)? onChanged})
      : answer = SizedBox(
            height: scrollDirection == Axis.vertical ? null : 30.h,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: scrollDirection,
                physics: scrollDirection == Axis.vertical
                    ? const NeverScrollableScrollPhysics()
                    : null,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Radio(
                        activeColor: activeColor ?? Colors.green,
                        value: value[index],
                        groupValue: groupValue,
                        onChanged: onChanged,
                        visualDensity: const VisualDensity(horizontal: -4),
                      ),
                      scrollDirection == Axis.vertical
                          ? Flexible(
                              child: Text(
                                valueNames?[index] ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            )
                          : Text(
                              valueNames?[index] ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 10.w,
                    ),
                itemCount: value.length));



  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        heading,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      // kSpacer,
      answer,
    ]);
  }

  Register.date({
    super.key,
    void Function()? onTap,
    bool readonly = true,
    TextEditingController? controller,
    String? Function(String?)? validator,
    BuildContext? context,
    required this.heading,
    TextStyle? hintStyle,
  }) : answer = CustomTextField(
          controller: controller,
          validator: validator,
          readonly: readonly,
          hintStyle: hintStyle,
          suffixIcon: InkWell(
              onTap: onTap,
              child: const Icon(
                Icons.calendar_month_sharp,
                color: Colors.green,
              )),
        );
}
