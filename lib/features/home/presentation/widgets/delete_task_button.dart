
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class DeleteAndCancelTaskButton extends StatelessWidget {
  const DeleteAndCancelTaskButton({
    super.key, required this.operation,
    required this.titleButton,
    required this.isDelete
  });
  final void Function() operation;
  final String titleButton;
  final bool isDelete;
  @override
  Widget build(BuildContext context) {
      return InkWell(
      onTap: operation,
      child: Container(
        width: 100.w,
        height: 40.h,
        decoration: ShapeDecoration(
            color:isDelete?ColorManager.waitingButton:Colors.white ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side:isDelete?BorderSide.none:BorderSide(
                    strokeAlign: 1,
                    color:ColorManager.waitingText
                )
            )),
        child: Center(
          child: CustomTextWidget(
              title: titleButton,
              colorText:isDelete?ColorManager.waitingText:Colors.black,
              size: 14.sp,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );;
  }
}
