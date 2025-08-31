
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key,  required this.items, required this.title});
 final List<Widget>items;
 final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Center(
        child: CustomTextWidget(
            title: title,
            colorText: Colors.black,
            size: 18.sp,
            fontWeight: FontWeight.w500
        ),
      ),
      actions:items ,
    );
  }
}
