
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/functions/capitalize_text.dart';
import '../../../../core/utils/app_colors.dart' show ColorManager;
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';

class SelectTaskPriority extends StatelessWidget {
  const SelectTaskPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomDropdown(
      backgroundColor:ColorManager.inprogressButton,
      value: context.read<TaskOperationsCubit>().selectedPriority,
      hintText: 'Choose Priority',
      messageForValidate: 'Please Choose Priority',
      border: AppConstants.removeBorder,
      focusedBorder: AppConstants.removeBorder,
      icon: Icon(
        Icons.arrow_drop_down_sharp,
        color:ColorManager.buttonColor,
        size: 25.sp,
      ),
      items: ['low', 'medium', 'high']
          .map(
            (value) => DropdownMenuItem(
          value:value,
          child: Row(
            children: [
              Icon(
                Icons.flag_outlined,
                color: ColorManager.buttonColor,
                size: 18.sp,
              ),
              SizedBox(width:7.h,),
              CustomTextWidget(
                  title: capitalize('$value Priority'),
                  colorText: ColorManager.buttonColor,
                  fontWeight: FontWeight.w700,
                  size: 16.sp
              ),
            ],
          ),
        ),
      ).toList(),
      onChange: (value) {
        context.read<TaskOperationsCubit>().selectedPriority= value;
      },
    );
  }
}
