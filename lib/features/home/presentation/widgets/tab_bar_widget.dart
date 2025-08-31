
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart' show ColorManager;
import '../../../../core/utils/app_constants.dart';
import 'custom_tab_item.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return  TabBar(
        controller:  AppConstants.tabController,
        splashBorderRadius:BorderRadius.circular(12.r),
        tabAlignment:TabAlignment.center,
        dividerColor: Colors.white,
        indicatorColor: Colors.white,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        onTap: (index){
          setState(() {
            AppConstants.tabController.index = index;
          });
        },
        tabs: [
          Tab(
              child: CustomTabContainer(
                title: TextManager.allTaskText,
                containerColor:AppConstants.tabController.index==0?ColorManager.buttonColor:ColorManager.unselectedButton,
                textColor:AppConstants.tabController.index==0? Colors.white:Colors.black,
              )
          ),
          Tab(
              child: CustomTabContainer(
                title: TextManager.inprogressTaskText,
                containerColor: AppConstants.tabController.index==1?ColorManager.buttonColor:ColorManager.unselectedButton,
                textColor: AppConstants.tabController.index==1? Colors.white:Colors.black,
              )
          ),
          Tab(
              child: CustomTabContainer(
                title: TextManager.waitingTaskText,
                containerColor: AppConstants.tabController.index==2?ColorManager.buttonColor:ColorManager.unselectedButton,
                textColor: AppConstants.tabController.index==2? Colors.white:Colors.black,
              )
          ),
          Tab(
              child: CustomTabContainer(
                title: TextManager.finishedTaskText,
                containerColor:AppConstants.tabController.index==3?ColorManager.buttonColor:ColorManager.unselectedButton,
                textColor: AppConstants.tabController.index==3? Colors.white:Colors.black,
              )
          ),
        ]
    );
  }
}
