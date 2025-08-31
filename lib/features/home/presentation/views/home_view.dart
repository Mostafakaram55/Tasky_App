
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_constants.dart';
import 'package:tasky_app/core/utils/app_strings.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../widgets/alert_dialog_widget.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/home_view_body.dart';
import '../widgets/logged_out_widget.dart';
import '../widgets/tab_bar_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    AppConstants.tabController=TabController(length: 4, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    AppConstants.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AppAssets.splashImage,
          fit: BoxFit.cover,
        ),

        leading: SizedBox(),
        elevation: 0,
        backgroundColor: ColorManager.buttonColor,
        actions: [
          CustomIconButton(
            iconBroken: IconBroken.Profile,
            operation: (){
              AppRouter.navigateTo(AppRouter.profileView);
            },
            colorIcon: Colors.white,
          ),
          CustomIconButton(
            iconBroken: IconBroken.Logout,
            operation: (){
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialogWidget(
                    title: TextManager.titleDialogLogOut,
                    items: [
                      Padding(
                        padding:  EdgeInsets.only(bottom: 20.h),
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
                        padding:  EdgeInsets.only(bottom: 20.h),
                        child: LoggedOutWidget(
                          operation: (){
                            AppRouter.goBack();
                          }, icon: IconBroken.Close_Square,
                        ),
                      ),
                    ],
                  );
                }
              );
            },
            colorIcon: Colors.white,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Container(
            color:Colors.white,
            width: double.infinity,
            child: Padding(
              padding:  EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    title: TextManager.myTasks,
                    colorText:Colors.grey ,
                    fontWeight: FontWeight.bold,
                    size: 16.sp,
                  ),
                  SizedBox(height: 8.h,),
                  TabBarWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      body:const HomeViewBody(),
      floatingActionButton:FloatingActionButtonsSection(),
    );
  }
}