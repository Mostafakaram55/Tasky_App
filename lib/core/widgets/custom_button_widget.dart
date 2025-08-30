import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_assets.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.isIcon,
    required this.titleButton
  });
  final VoidCallback onPressed;
  final bool? isIcon;
  final String titleButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width:double.infinity ,
        decoration: BoxDecoration(
            color: ColorManager.buttonColor,
            borderRadius: BorderRadius.circular(12.r)
        ),
        height: 49.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleButton,
              style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 19.sp
              ),
            ),
            SizedBox(width: 5.w,),
            Image.asset(
              AppAssets.arrowLeft,
              height: 24.h,
              width: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}