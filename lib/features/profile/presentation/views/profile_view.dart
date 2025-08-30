
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/routes/app_routes.dart' show AppRouter;
import '../../../../core/utils/app_colors.dart';
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
        leading: CustomIconButton(iconBroken: IconBroken.Arrow___Left_3, operation: (){
          AppRouter.goBack();
        }, colorIcon: Colors.white),
      ) ,
      body: Padding(
        padding:  EdgeInsets.all(20.r),
        child: ProfileViewBody(),
      ),
    );
  }
}
