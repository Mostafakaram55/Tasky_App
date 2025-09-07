
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/features/home/presentation/cubits/get_task_cubit/get_task_cubit.dart';

import '../../../../config/routes/app_routes.dart';

class FloatingActionButtonsSection extends StatelessWidget {
  const FloatingActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<GetTasksCubit>(),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                context.push(AppRouter.scanView,extra:context).then((value){
                  if(value!=null && value==true){
                    if(context.mounted){
                      context.read<GetTasksCubit>().getAllTasks(newGetList: true);
                    }
                  }
                });
              },
              backgroundColor: Colors.white,
              child:  SvgPicture.asset(
                AppAssets.scan_image,
                width: MediaQuery.sizeOf(context).width > 700
                    ? 26.sp
                    : 29.sp,
                color: ColorManager.buttonColor,
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          SizedBox(
            width: 45.w,
            height: 45.h,
            child: FloatingActionButton(
              heroTag: '2',
              onPressed: () {
                context.push(AppRouter.kAddTaskView,).then((value){
                  if(value!=null&&value==true){
                    if(context.mounted){
                   context.read<GetTasksCubit>().getAllTasks(newGetList: true);
                  }
                  }
                });
              },
              backgroundColor: ColorManager.buttonColor,
              child: Icon(
                Icons.add_rounded,
                size: MediaQuery.sizeOf(context).width > 780
                    ? 25.sp
                    : 28.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}