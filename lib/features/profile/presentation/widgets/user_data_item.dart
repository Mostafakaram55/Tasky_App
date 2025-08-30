import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class UserDataItem extends StatelessWidget {
   UserDataItem({super.key, required this.title, required this.subtitle,this.textCopy});
  final String title;
  final String subtitle;
  Widget? textCopy;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(12.r),
        color: ColorManager.colorUserItem,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
                title: title.toUpperCase(),
                colorText:Color(0x662F2F2F),
                size: 12.sp,
                fontWeight: FontWeight.w500
            ),
            SizedBox(height: 10.h,),
            Row(
              children: [
                CustomTextWidget(
                    title: subtitle,
                    colorText:Colors.blueGrey,
                    size: 18.sp,
                    fontWeight: FontWeight.w700
                ),
                Spacer(),
                textCopy??SizedBox(width: 30.h,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
