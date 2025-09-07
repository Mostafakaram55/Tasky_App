
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
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
        icon: SvgPicture.asset(
          AppAssets.arrow_down,
          color: ColorManager.buttonColor,
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
              size: 16.sp
         ),
    ),
    ).toList(),
    onChange: (value) {
     context.read<TaskOperationsCubit>().selectedStatus = value??'';
    }
    );
  }
}
