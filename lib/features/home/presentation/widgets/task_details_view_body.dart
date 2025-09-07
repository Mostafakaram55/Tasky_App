
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/api/end_pionts.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/review_statue_and_priority_task_details.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_priority.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_status.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_qr_code_details.dart';

import '../../../../core/functions/capitalize_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_network_image.dart';
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
    TaskOperationsCubit.get(context).selectedStatus=widget.taskEntity.status??'';
    TaskOperationsCubit.get(context).selectedPriority=widget.taskEntity.priority??'Low';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(widget.taskEntity.createdAt);
    String formattedDate = DateFormat('d MMMM, yyyy').format(parsedDate);
    String imageUrl = widget.taskEntity.image.contains('http') ? widget.taskEntity.image : "${EndPoints.baseUrlEndpoint}${EndPoints.viewImage}${widget.taskEntity.image}";
    return  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AspectRatio(
              aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CustomNetworkImage(
                    image: imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h,),
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
                SizedBox(height: 10.h,),
                ReviewTaskDetails(
                  title: formattedDate,
                  isPriority: false,
                  image:AppAssets.calendar ,
                  color: Color(0xFf24252C),
                  fontWeight: FontWeight.w400,
                  sizeText: 15.sp,
                ),
                SizedBox(height: 8.h,),
                ReviewTaskDetails(
                  image:AppAssets.arrow_down ,
                  isPriority: false,
                  title:capitalize(widget.taskEntity.status??''),
                ),
                SizedBox(height: 8.h,),
                ReviewTaskDetails(
                  image:AppAssets.arrow_down ,
                  title: capitalize('${widget.taskEntity.priority} Priority')??'',
                  isPriority: true,
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            TaskDetailsQrCode(taskId: widget.taskEntity.id,),
          ],
        ),
      ),
    );
  }
}