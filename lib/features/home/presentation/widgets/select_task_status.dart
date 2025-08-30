
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/functions/capitalize_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';

class SelectTaskStatus extends StatelessWidget {
  const SelectTaskStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomDropdown(
     backgroundColor:ColorManager.inprogressButton,
     value:  context.read<TaskOperationsCubit>().selectedStatus,
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          color:ColorManager.buttonColor,
          size: 25.sp,
        ),
    hintText: 'Choose Status',
    messageForValidate: 'Please Choose Status',
    items:['inprogress','waiting','finished']
        .map(
    (value) => DropdownMenuItem(
    value: value,
    child:CustomTextWidget(
               title: capitalize(value),
              colorText: ColorManager.buttonColor,
               fontWeight: FontWeight.w700,
              size: 17.sp
         ),
    ),
    ).toList(),
    onChange: (value) {
     context.read<TaskOperationsCubit>().selectedStatus = value;
    }
    );
  }
}
