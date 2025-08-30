import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class HaveEmailOrNot extends StatelessWidget {
  const HaveEmailOrNot({
    super.key,
    required this.operationName,
    required this.titleButton,
    required this.operation
  });
  final String operationName;
  final String titleButton ;
  final VoidCallback operation;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWidget(
          colorText: Colors.grey,
          fontWeight: FontWeight.w400,
          size: 14.sp,
          title: operationName,
        ),
        TextButton(onPressed: operation,
            child:CustomTextWidget(
                title:titleButton ,
                colorText:ColorManager.buttonColor,
                size: 14.sp,
                fontWeight: FontWeight.w400
            ))
      ],
    );
  }
}