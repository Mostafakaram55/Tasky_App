
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text_widget.dart';

class CustomTabContainer extends StatelessWidget {
  const CustomTabContainer({
    super.key, required this.title,
    required this.containerColor,
    required this.textColor});
  final String title;
  final Color containerColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: containerColor,
      ),
      child:Padding(
        padding:  EdgeInsets.all(8.0.r),
        child: CustomTextWidget(
            title: title,
            colorText: textColor,
            size: 16.sp,
            fontWeight: FontWeight.w400
        ),
      ) ,
    );
  }
}
