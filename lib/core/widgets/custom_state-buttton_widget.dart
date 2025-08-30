import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text_widget.dart';

class StateButtonWidget extends StatelessWidget {
  const StateButtonWidget({
    super.key,
    required this.title,
    required this.colorText,
    required this.buttonColor
  });
  final String title;
  final Color colorText;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: buttonColor,
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.r),
        child: CustomTextWidget(
            title:title ,
            colorText: colorText,
            size: 12.sp,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
