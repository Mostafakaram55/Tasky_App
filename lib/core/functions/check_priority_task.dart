import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Icon(
              Icons.flag_outlined,
              size: 17.sp,
              color: ColorManager.inprogressText,
            ),
            CustomTextWidget(
                title: capitalize(priority),
                colorText: ColorManager.inprogressText,
                size: 16.sp,
                fontWeight: FontWeight.w700
            ),
          ],
        )
      ];
    case 'low':
      return [
        Row(
          children: [
            Icon(
              Icons.flag_outlined,
              size: 17.sp,
              color: ColorManager.finishedText,
            ),
            CustomTextWidget(
                title: capitalize(priority),
                colorText: ColorManager.finishedText,
                size: 16.sp,
                fontWeight: FontWeight.w700
            ),
          ],
        )
      ];
    case 'high':
      return [
        Row(
          children: [
            Icon(
              Icons.flag_outlined,
              size: 17.sp,
              color: ColorManager.waitingText,
            ),
            CustomTextWidget(
                title: capitalize(priority),
                colorText: ColorManager.waitingText,
                size: 16.sp,
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