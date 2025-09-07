import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../functions/show_snak_bar.dart';
import '../utils/app_colors.dart';

class CopyIconButton extends StatelessWidget {
  final String textToCopy;

  const CopyIconButton({super.key, required this.textToCopy});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.copy,
          color:ColorManager.buttonColor,
          size: 24.sp,
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: textToCopy));
          showToastificationWidget(
            message:'Text copied successfully!',
            context: context,
            notificationType:ToastificationType.success
          );
        },
      ),
    );
  }
}