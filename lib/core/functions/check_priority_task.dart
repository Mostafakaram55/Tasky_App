import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_state-buttton_widget.dart';
import '../widgets/custom_text_widget.dart';
import 'capitalize_text.dart';

List<Widget> getStatusWidget(String priority) {
  switch (priority.toLowerCase()) {
    case 'medium':
      return [
        Row(
          children: [
            SvgPicture.asset(
              AppAssets.flag,
              height: 16.h,
              width: 16.w,
              color: ColorManager.inprogressText,
            ),
            SizedBox(width: 5,),
            CustomTextWidget(
                title: capitalize(priority),
                colorText: ColorManager.inprogressText,
                size: 12.sp,
                fontWeight: FontWeight.w700
            ),
          ],
        )
      ];
    case 'low':
      return [
        Row(
          children: [
            SvgPicture.asset(
              AppAssets.flag,
              height: 16.h,
              width: 16.w,
              color: ColorManager.finishedText,
            ),
            SizedBox(width: 5,),
            CustomTextWidget(
                title: capitalize(priority),
                colorText: ColorManager.finishedText,
                size: 12.sp,
                fontWeight: FontWeight.w700
            ),
          ],
        )
      ];
    case 'high':
      return [
        Row(
          children: [
            SvgPicture.asset(
              AppAssets.flag,
              height: 16.h,
              width: 16.w,
              color: ColorManager.waitingText,
            ),
            SizedBox(width: 5,),
            CustomTextWidget(
                title: capitalize(priority),
                colorText: ColorManager.waitingText,
                size: 12.sp,
                fontWeight: FontWeight.w700
            ),
          ],
        )
      ];
    default:
      return [];
  }
}
List<Widget> getPriorityButton(String priority) {
  switch (priority.toLowerCase()) {
    case 'inprogress':
      return [
        StateButtonWidget(
          title: capitalize(priority),
          colorText:ColorManager.inprogressText,
          buttonColor:ColorManager.inprogressButton ,
        ),
      ];
    case 'finished':
      return [
        StateButtonWidget(
          title: capitalize(priority),
          colorText:ColorManager.finishedText,
          buttonColor:ColorManager.finishedButton ,
        ),
      ];
    case 'waiting':
      return [
        StateButtonWidget(
          title: capitalize(priority),
          colorText:ColorManager.waitingText,
          buttonColor:ColorManager.waitingButton ,
        ),
      ];
    default:
      return [];
  }
}