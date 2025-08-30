import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.iconData, this.operation, required this.title});
  final IconData iconData;
  final void Function()? operation;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          iconBroken: iconData,
          operation: operation,
          colorIcon: Colors.white,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700
          ),
        )
      ],
    );
  }
}