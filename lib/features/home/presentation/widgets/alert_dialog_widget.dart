
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import 'logged_out_widget.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Center(
        child: CustomTextWidget(
            title: TextManager.titleDialogLogOut,
            colorText: Colors.black,
            size: 18.sp,
            fontWeight: FontWeight.w500
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: LoggedOutWidget(
            operation: (){
              CacheHelper.remove(key: 'access_token').then((_) {
                if (context.mounted) {
                  AppRouter.navigateTo(
                    AppRouter.kSignInView,
                  );
                }
              }
              );
            }, icon: IconBroken.Logout,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: LoggedOutWidget(
            operation: (){
              AppRouter.goBack();
            }, icon: IconBroken.Close_Square,
          ),
        ),

      ],
    );
  }
}
