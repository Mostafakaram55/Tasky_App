
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/widgets/custom_text_widget.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class LoggedOutWidget extends StatelessWidget {
  const LoggedOutWidget({super.key, required this.operation, required this.okLogOut, required this.titleButton});
final void Function() operation;
final bool okLogOut;
final String titleButton;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: operation,
      child: Container(
        width: 100.w,
        height: 40.h,
        decoration: ShapeDecoration(
          color:okLogOut?ColorManager.buttonColor:Colors.white ,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side:okLogOut? BorderSide.none:BorderSide(
            strokeAlign: 1,
            color: Colors.grey
          )
        )),
        child: Center(
          child: CustomTextWidget(
              title: titleButton,
              colorText:okLogOut?Colors.white: Colors.black,
              size: 14.sp,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
