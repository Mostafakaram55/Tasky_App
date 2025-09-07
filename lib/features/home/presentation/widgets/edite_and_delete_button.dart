import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class EditeAndDeleteButton extends StatelessWidget {
  const EditeAndDeleteButton({
    super.key, required this.edite,
    required this.delete, this.color,
  });

  final void Function() edite;
  final void Function(BuildContext context) delete;
  final Color?color;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconColor:color?? Colors.white,
        position: PopupMenuPosition.under,
        color: Colors.white,
        elevation: 9,
        padding: EdgeInsets.zero,
        popUpAnimationStyle: AnimationStyle(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          reverseDuration: const Duration(milliseconds: 300),
          reverseCurve: Curves.easeOut,
        ),
        borderRadius: BorderRadius.circular(8.r),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: TextButton(
              onPressed:edite,
              child: CustomTextWidget(
                title: TextManager.edit,
                size: 16.sp,
                fontWeight: FontWeight.w500,
                colorText: Colors.black,
              ),
            ),
          ),
          PopupMenuItem(
              height: 5,
              child: Center(child: Divider())
          ),
          PopupMenuItem(
            value: 'Delete',
            child: TextButton(
              onPressed:(){
                delete(context);
                } ,
              child: CustomTextWidget(
                title: TextManager.delete,
                size: 16.sp,
                fontWeight: FontWeight.w500,
                colorText: ColorManager.waitingText,
              ),
            ),)
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.more_vert_outlined),
        ),
    );
  }
}
