
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/core/utils/app_assets.dart';

class ArrowLeftIcon extends StatelessWidget {
  const ArrowLeftIcon({super.key, this.operation});
  final void Function()? operation;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:operation ,
      child: SvgPicture.asset(
        width: 25.w,
          height: 28.h,
          AppAssets.arrowLeft,
      ),
    );
  }
}
