import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../cubits/get_task_cubit/get_task_cubit.dart';
import '../widgets/alert_dialog_widget.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/home_view_body.dart';
import '../widgets/logged_out_widget.dart';
import '../widgets/tab_bar_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<GetTasksCubit>().getAllTasks(newGetList: true);
    AppConstants.tabController = TabController(length: 4, vsync: this);
    super.initState();
  }
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isRefresh=GoRouterState.of(context).extra as bool ?;
    if(isRefresh==true){
      context.read<GetTasksCubit>().getAllTasks(newGetList: true);
    }
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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AppAssets.logo_app,
            fit: BoxFit.cover,
            height: 32.h,
            width: 50.w,
          ),
        ),
        leadingWidth: 100.w,
        elevation: 0,
        backgroundColor: ColorManager.buttonColor,
        actions: [
          CustomIconButton(
            iconBroken: IconBroken.Profile,
            operation: () {
              context.push(AppRouter.profileView);
            },
            colorIcon: Colors.white,
          ),
          CustomIconButton(
            iconBroken: IconBroken.Logout,
            operation: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      subTitle: 'Are you sure you want to log out ?',
                      iconType:IconBroken.Logout ,
                      title: 'Log out',
                      items: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: LoggedOutWidget(
                            okLogOut: false,
                            titleButton: 'No',
                            operation: () {
                              context.pop();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: LoggedOutWidget(
                            operation: () {
                              CacheHelper.remove(key: 'access_token').then((
                                  _) {
                                if (context.mounted) {
                                  context.go(
                                    AppRouter.kSignInView,
                                  );
                                }
                              }
                              );
                            },
                            okLogOut: true,
                            titleButton: 'Ok',
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
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    title: TextManager.myTasks,
                    colorText: Colors.grey,
                    fontWeight: FontWeight.w700,
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
      body: const HomeViewBody(),
      floatingActionButton: FloatingActionButtonsSection(),
    );
  }
}