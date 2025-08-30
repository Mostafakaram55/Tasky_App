import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.textEditingController,
    required this.textInputType,
    required this.obscureText,
    required this.validator,
    required this.hintText,
    this.widgetIconPrefix,
    this.widgetIconsuffix,
    this.maxLines,
    this.readOnly, this.fontWeightHint, this.sizeHint, this.colorHint,
  });
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscureText ;
  final String? Function(String?)? validator;
  final String hintText;
  final Widget? widgetIconPrefix;
  final Widget? widgetIconsuffix;
  final int? maxLines;
  final bool? readOnly;
  final FontWeight?fontWeightHint;
  final double?sizeHint;
  final Color?colorHint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly??false,
      maxLines: maxLines??1,
      validator: validator,
      cursorColor: ColorManager.buttonColor,
      obscureText:obscureText ,
      keyboardType:textInputType ,
      controller:textEditingController ,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: widgetIconsuffix,
        prefixIcon: widgetIconPrefix,
        filled: true,
        isDense: true,
        hintStyle: TextStyle(
                color: colorHint??Color(0xFFBABABA),
              fontSize:sizeHint?? 14.sp,
                fontWeight: fontWeightHint??FontWeight.w400
             ),
        fillColor:ColorManager.fillColorTextFiled ,
        border: AppConstants.enabledBorder,
        focusedBorder: AppConstants.focusedBorder,
      ),

    );
  }
}