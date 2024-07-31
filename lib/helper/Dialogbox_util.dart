import 'package:flutter/material.dart';

Future dialogBox(
    {BuildContext? context,
    List<Widget>? actions,
    Widget? title,
    Widget? content}) {
  return showDialog<void>(
    barrierDismissible: false,
    useSafeArea: true,
    context: context!,
    builder: (BuildContext context) {
      return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: title ?? const SizedBox(),
          titlePadding: title != null
              ? const EdgeInsets.only(top: 24, right: 24, left: 24)
              : EdgeInsets.zero,
          content: content ??
              const Text(
                'A dialog is a type of modal window that\n'
                'appears in front of app content to\n'
                'provide critical information, or prompt\n'
                'for a decision to be made.',
              ),
          actions: actions);
    },
  );
}
