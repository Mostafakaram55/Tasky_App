
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/widgets/custom_text_widget.dart';

class ReviewTaskDetails extends StatelessWidget {
  const ReviewTaskDetails({super.key, required this.title, this.isPriority, this.color, required this.image, this.sizeText, this.fontWeight});
  final String title;
  final String image;
  final Color? color;
  final FontWeight? fontWeight;
  final double? sizeText;
  final bool? isPriority;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 49.h,
      decoration: ShapeDecoration(
        color: ColorManager.inprogressButton,
          shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(8.r),
      )),
      child: Padding(
        padding: const EdgeInsets.only(left: 24,right: 13),
        child: Row(
          children: [
          if(isPriority==true)...{
            SvgPicture.asset(
              'assets/images/flag.svg',
              height:22.h ,
              width:22.w ,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 4.w,),
          },
            CustomTextWidget(
                title: title,
                colorText:color??ColorManager.inprogressText,
                size: sizeText??16.sp,
                fontWeight: fontWeight??FontWeight.w700,

            ),
            Expanded(child: SizedBox()),
            SvgPicture.asset(
              image,
              height:22.h ,
              width:22.w ,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
