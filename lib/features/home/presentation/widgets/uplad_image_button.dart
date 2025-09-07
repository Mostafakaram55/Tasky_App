
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({super.key, required this.operation, required this.titleButton});
  final void Function() operation;
  final String titleButton;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: operation,
      child: Container(
        width: 100.w,
        height: 40.h,
        decoration: ShapeDecoration(
            color:ColorManager.inprogressButton ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side:BorderSide(
                    strokeAlign: 1,
                    color: ColorManager.buttonColor
                )
            )),
        child: Center(
          child: CustomTextWidget(
              title: titleButton,
              colorText:ColorManager.buttonColor,
              size: 14.sp,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
