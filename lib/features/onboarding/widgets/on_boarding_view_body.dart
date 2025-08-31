
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/config/local/cache_helper.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_image_log.dart';
import '../../../core/widgets/custom_text_widget.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomImageLogo(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15.h,
              ),
              CustomTextWidget(
                colorText:Colors.black ,
                fontWeight:FontWeight.w700 ,
                size:24.sp ,
                title:TextManager.onBoardinText1,
                maxLines: 2,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextWidget(
                colorText:Colors.grey ,
                fontWeight:FontWeight.w400 ,
                size:15.sp ,
                title:TextManager.onBoardinText2,
                maxLines: 3,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding:EdgeInsets.only(bottom: 10.h,right: 20.w,left: 20.w),
                child: CustomButton(
                  onPressed: (){
                    CacheHelper.saveData(key:'isOnBoardingVisited',value: true);
                    context.go(AppRouter.kSignInView);
                  },
                  isIcon: true,
                  titleButton: TextManager.titleButtonStart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}