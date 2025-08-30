import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(
            'assets/nodata.json',
            fit: BoxFit.cover,
          ),
          CustomTextWidget(
              title: title,
              colorText: Colors.black,
              size: 18,
              fontWeight:FontWeight.w400
          )
        ],
      ),
    );
  }
}