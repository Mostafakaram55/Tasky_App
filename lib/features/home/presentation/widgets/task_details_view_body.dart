
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/api/end_pionts.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_priority.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_status.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_qr_code_details.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../domain/entites/task_entity.dart' show TaskEntity;
import '../cubits/task_crud_cubit/task_curd_cubit.dart';


class DetailsTaskViewBody extends StatefulWidget {
  const DetailsTaskViewBody({super.key,required this.taskEntity});
  final   TaskEntity taskEntity;

  @override
  State<DetailsTaskViewBody> createState() => _DetailsTaskViewBodyState();
}

class _DetailsTaskViewBodyState extends State<DetailsTaskViewBody> {
  @override
  void initState() {
    TaskOperationsCubit.get(context).selectedStatus=widget.taskEntity.status;
    TaskOperationsCubit.get(context).selectedPriority=widget.taskEntity.priority;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(widget.taskEntity.createdAt);
    String formattedDate = DateFormat('d MMMM, yyyy').format(parsedDate);
    String imageUrl = widget.taskEntity.image.contains('http') ? widget.taskEntity.image : "${EndPoints.baseUrlEndpoint}${EndPoints.viewImage}${widget.taskEntity.image}";
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                    title:widget.taskEntity.title ,
                    colorText: Colors.black,
                    size: 24.sp,
                    fontWeight: FontWeight.w700
                ),
                SizedBox(height: 10.h,),
                Text(
                  widget.taskEntity.desc,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h,),
            Column(
              children: [
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.inprogressButton,
                    suffixIcon: Image.asset(AppAssets.calendar),
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.sp
                    ),
                    hintText:formattedDate ,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                SelectTaskPriority(),
                // DropdownButtonFormField(
                //   iconSize: 30.sp,
                //   iconEnabledColor: ColorManager.buttonColor,
                //   dropdownColor: Colors.white,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please select a states';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: ColorManager.inprogressButton,
                //     prefixIcon: Icon(
                //       Icons.flag_outlined,
                //       color: ColorManager.buttonColor,
                //     ),
                //     hintText: 'Select priority',
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12.r),
                //         borderSide: BorderSide.none
                //     ),
                //     enabledBorder:OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12.r),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                //   value:taskEntity.status,
                //   onChanged: (newPriority) {
                //     context.read<TaskOperationsCubit>().selectedStatusTask(
                //       selectedStatus: newPriority??taskEntity.status,
                //     );
                //   },
                //   items:['inprogress','waiting','finished']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem(
                //       value: value,
                //       child: CustomTextWidget(
                //           title: capitalize(value),
                //           colorText: ColorManager.buttonColor,
                //           fontWeight: FontWeight.w700,
                //           size: 17.sp
                //       ),
                //     );
                //   }).toList(),
                // ),
                SizedBox(height: 10.h,),
                SelectTaskStatus(),
                // DropdownButtonFormField(
                //   iconSize: 30.sp,
                //   iconEnabledColor: ColorManager.buttonColor,
                //   dropdownColor: Colors.white,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please select a priority';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: ColorManager.inprogressButton,
                //     prefixIcon: Icon(
                //       Icons.flag_outlined,
                //       color: ColorManager.buttonColor,
                //     ),
                //     hintText: 'Select priority',
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12.r),
                //         borderSide: BorderSide.none
                //     ),
                //     enabledBorder:OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12.r),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                //   value:taskEntity.priority,
                //   onChanged: (newPriority) {
                //     context.read<TaskOperationsCubit>().selectedPriorityTask(
                //       selectedPriority: newPriority??taskEntity.priority,
                //     );
                //   },
                //   items:['low','medium','high']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem(
                //       value: value,
                //       child: CustomTextWidget(
                //           title: capitalize('$value priority '),
                //           colorText: ColorManager.buttonColor,
                //           fontWeight: FontWeight.w700,
                //           size: 17.sp
                //       ),
                //     );
                //   }).toList(),
                // ),
              ],
            ),
            SizedBox(height: 10.h,),
            TaskDetailsQrCode(taskId: widget.taskEntity.id,),
          ],
        ),
      ),
    );
  }
}