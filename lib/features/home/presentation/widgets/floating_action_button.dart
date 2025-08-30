
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
                context.push(AppRouter.scanView,extra:context );
              },
              backgroundColor: Colors.white,
              child:  Icon(
                Icons.qr_code,
                size: MediaQuery.sizeOf(context).width > 780
                    ? 25.sp
                    : 28.sp,
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
                context.push(AppRouter.kAddTaskView,);
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