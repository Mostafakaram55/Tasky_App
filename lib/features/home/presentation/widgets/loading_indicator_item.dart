
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemLoadingIndicator extends StatelessWidget {
  const ItemLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 2,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child:Container(
            color: Colors.grey[200],
          )
      ),
    );
  }
}
