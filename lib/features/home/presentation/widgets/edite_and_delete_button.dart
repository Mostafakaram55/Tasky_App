import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class EditeAndDeleteButton extends StatelessWidget {
  const EditeAndDeleteButton({
    super.key, required this.edite,
    required this.delete,
  });

  final void Function() edite;
  final void Function() delete;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconColor: Colors.white,
        position: PopupMenuPosition.under,
        color: Colors.white,
        elevation: 9,
        itemBuilder: (context) => [
          PopupMenuItem(
            child: TextButton(
              onPressed:edite,
              child: CustomTextWidget(
                title: TextManager.edit,
                size: 18.sp,
                fontWeight: FontWeight.w500,
                colorText: Colors.black,
              ),
            ),
          ),
          PopupMenuItem(
              height: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.8),
                child: Divider(),
              )
          ),
          PopupMenuItem(
            value: 'Delete',
            child: TextButton(
              onPressed: delete,
              child: CustomTextWidget(
                title: TextManager.delete,
                size: 18.sp,
                fontWeight: FontWeight.w500,
                colorText: ColorManager.waitingText,
              ),
            ),)
        ]
    );
  }
}
