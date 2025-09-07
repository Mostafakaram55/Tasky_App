import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/widgets/custom_text_widget.dart';

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
               CustomTextWidget(
                  size:19.sp ,
                title: titleButton,
                   colorText:ColorManager.white
                 , fontWeight: FontWeight.w700,
              ),
            SizedBox(width: 5.w,),
            SvgPicture.asset(
              AppAssets.arrowRight,
              height: 24.h,
              width: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}