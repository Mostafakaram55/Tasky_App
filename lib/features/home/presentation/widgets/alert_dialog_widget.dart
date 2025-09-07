
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/config/icons/icons_broken.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,  required this.items,
    required this.title,
    required this.subTitle,
    required this.iconType,
    this.colorContainer,
    this.colorIcon});

 final List<Widget>items;
 final String title;
 final String? subTitle;
 final IconData iconType;
 final Color? colorContainer;
 final Color? colorIcon;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Center(
        child: Column(
          children: [
           Container(
             decoration: BoxDecoration(
               color: colorContainer??ColorManager.inprogressButton,
              shape:BoxShape.circle,
            ),
             child: Padding(
               padding:  EdgeInsets.all(8.0.r),
               child: Icon(
                 iconType,
                 color: colorIcon??ColorManager.buttonColor,
               ),
             ),
           ),
            SizedBox(height: 10,),
            CustomTextWidget(
                title: title,
                colorText: Colors.black,
                size: 16.sp,
                fontWeight: FontWeight.w400
            ),
            SizedBox(height: 7.h,),
            if(subTitle!=null)...{
              CustomTextWidget(
                title: subTitle!,
                colorText: Colors.grey,
                size: 14.sp,
                fontWeight: FontWeight.w300
            ),
            },
          ],
        ),
      ),
      actions:items ,
    );
  }
}
