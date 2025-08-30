import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

import '../utils/app_constants.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.validator,
    this.value,
    required this.hintText,
    this.paddingForTop,
    this.paddingForBottom,
    required this.messageForValidate,
    required this.items,
    required this.onChange, this.icon, this.backgroundColor, this.border, this.focusedBorder,
  });

  final String? Function(String?)? validator;
  final String hintText;
  final String messageForValidate;
  final double? paddingForTop;
  final dynamic value;
  final double? paddingForBottom;
  final List<DropdownMenuItem> items;
  final Function(dynamic value) onChange;
  final Widget? icon;
  final Color? backgroundColor;
  final InputBorder? border ;
  final InputBorder? focusedBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: paddingForBottom ?? 15.sp,
      ),
      child: DropdownButtonFormField(
        value: value,
        itemHeight: 52.h,
        iconSize: MediaQuery.sizeOf(context).width > 780
            ? 16.sp
            : 25.sp,
        validator: (value) => value == null ? messageForValidate : null,
        style:GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color:Colors.black
        ),

        decoration: InputDecoration(
          fillColor: backgroundColor??Colors.white,
          filled: true,
          isDense: MediaQuery.sizeOf(context).width > 780 ? false : true,
          hintStyle: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color:Colors.grey
          ),
          border: border?? AppConstants.enabledBorder,
          focusedBorder: focusedBorder??AppConstants.enabledBorder,
        ),
        isExpanded: true,
        borderRadius: BorderRadius.circular(8.r),
        hint: Text(
          hintText,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color:Colors.grey
          ),
        ),
        items: items,
        onChanged: onChange,
        icon: icon??Icon(
          Icons.keyboard_arrow_down_rounded,
          size: MediaQuery.sizeOf(context).width > 780
              ?24.sp
              : 28.sp,
        ),
      ),
    );
  }
}