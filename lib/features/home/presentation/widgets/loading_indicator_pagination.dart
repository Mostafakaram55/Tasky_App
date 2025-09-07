
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicatorPagination extends StatelessWidget {
  const LoadingIndicatorPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Lottie.asset(
            'assets/loading_tasks.json',
            height: 50.h,
            width: 50.w
        )
    );
  }
}
