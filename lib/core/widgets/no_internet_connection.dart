import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_colors.dart';
import 'custom_text_widget.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/no internet.json',
              ),
              SizedBox(height: 24.h),
              CustomTextWidget(
                title: 'No Internet Connection',
                colorText: Colors.black,
                size: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12.h),
              CustomTextWidget(
                title: 'Please check your network and try again.',
                colorText: Colors.grey[700]!,
                size: 16.sp,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.buttonColor,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}