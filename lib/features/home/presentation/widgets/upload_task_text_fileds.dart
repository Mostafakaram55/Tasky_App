
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_priority.dart';

import '../../../../core/functions/capitalize_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart' show TaskOperationsCubit;

class SectionTaskFileds extends StatelessWidget {
  const SectionTaskFileds({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h,),
        CustomTextWidget(
            title: TextManager.taskTitle,
            colorText: ColorManager.titleFormAddTask,
            size: 14.sp,
            fontWeight: FontWeight.w400
        ),
        SizedBox(height: 8.h,),
        CustomTextFormFiled(
          textEditingController:context.read<TaskOperationsCubit>().titleTask ,
          textInputType: TextInputType.text,
          obscureText: false,
          validator: (value){
            if(value!.trim().isEmpty){
              return 'please enter task title';
            }
            return null;
          },
          hintText: 'Enter title here...',

        ),
        SizedBox(height: 16.h,),
        CustomTextWidget(
            title: TextManager.taskDescription,
            colorText: ColorManager.titleFormAddTask,
            size: 14.sp,
            fontWeight: FontWeight.w400
        ),
        SizedBox(height: 8.h,),
        CustomTextFormFiled(
          maxLines: 4,
          textEditingController:context.read<TaskOperationsCubit>().description ,
          textInputType: TextInputType.text,
          obscureText: false,
          validator: (value){
            if(value!.trim().isEmpty){
              return 'please enter task description';
            }
            return null;
          },
          hintText: 'Enter description here...',

        ),
        SizedBox(height: 16.h,),
        CustomTextWidget(
            title: 'Task Priority',
            colorText: ColorManager.titleFormAddTask,
            size: 14.sp,
            fontWeight: FontWeight.w400
        ),
        SizedBox(height: 8.h,),
        SelectTaskPriority(),
        SizedBox(height: 16.h,),
        CustomTextWidget(
            title: 'Due date',
            colorText: ColorManager.titleFormAddTask,
            size: 14.sp,
            fontWeight: FontWeight.w400
        ),
        SizedBox(height: 8.h,),
        CustomTextFormFiled(
          readOnly: true,
          widgetIconsuffix: GestureDetector(
            onTap: ()async{
              await context.read<TaskOperationsCubit>().uploadTaskDate(context);
            },
            child: Image.asset(
              AppAssets.calendar,
            ),
          ),
          textEditingController:context.read<TaskOperationsCubit>().deuData,
          textInputType: TextInputType.text,
          obscureText: false,
          validator: (value){
            if(value!.isEmpty){
              return 'please enter task date';

            }
            return null;
          },
          hintText: 'Enter Due date',
        ),
        SizedBox(height: 16.h,),
      ],
    );
  }
}