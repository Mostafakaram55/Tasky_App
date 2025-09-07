import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




import 'package:toastification/toastification.dart';

void showToastificationWidget({
  required String message,
  required BuildContext context,
  ToastificationType notificationType = ToastificationType.success,
  int duration = 3,
}) {
  toastification.show(
    context: context,
    title: Text(
      textAlign: TextAlign.center,
      message,
      maxLines: 3,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: Colors.black
      )
    ),
    type: notificationType,
    style: ToastificationStyle.flat,
    alignment: Alignment.topCenter,
    direction: TextDirection.rtl,
    autoCloseDuration: Duration(seconds: duration),
  );
}
