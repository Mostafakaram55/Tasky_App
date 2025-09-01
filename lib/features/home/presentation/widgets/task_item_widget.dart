import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/api/end_pionts.dart';
import '../../../../core/functions/check_priority_task.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_text_widget.dart' show CustomTextWidget;
import '../../domain/entites/task_entity.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskEntity
  });
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(taskEntity.updatedAt);
    String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    String imageUrl = taskEntity.image.contains('http')
        ? taskEntity.image
        : "${EndPoints.baseUrlEndpoint}${EndPoints.viewImage}${taskEntity.image}";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  imageUrl,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: Center(
                        child: Lottie.asset('assets/loading.json'),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.logoImage,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex:3,
                          child: CustomTextWidget(
                              title: taskEntity.title,
                              colorText: Colors.black,
                              size: 16.sp,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(width: 7.w,),
                        ...getPriorityButton(taskEntity.status),
                      ],
                    ),
                    SizedBox(height: 7.h,),
                    CustomTextWidget(
                        title: taskEntity.desc,
                        colorText: Colors.grey,
                        size: 14.sp,
                        fontWeight: FontWeight.w400
                    ),
                    SizedBox(height: 7.h,),
                    Row(
                      children: [
                        ...getStatusWidget(taskEntity.priority),
                        Spacer(),
                        CustomTextWidget(
                            title: formattedDate ,
                            colorText: Colors.grey, size: 12,
                            fontWeight: FontWeight.w400
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}