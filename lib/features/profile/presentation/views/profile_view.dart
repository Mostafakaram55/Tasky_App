
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/routes/app_routes.dart' show AppRouter;
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/arrow_left_icon.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../widgets/profile_view_body.dart' show ProfileViewBody;

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: false,
        backgroundColor:ColorManager.buttonColor,
        title:CustomTextWidget(title: 'Profile', colorText: Colors.white, size: 16.sp, fontWeight: FontWeight.w700),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ArrowLeftIcon(
            operation: context.pop,
          ),
        ),
        leadingWidth: 50.w,
      ) ,
      body: Padding(
        padding:  EdgeInsets.all(20.r),
        child: ProfileViewBody(),
      ),
    );
  }
}
