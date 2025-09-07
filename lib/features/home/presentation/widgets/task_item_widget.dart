import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/widgets/custom_network_image.dart';
import '../../../../core/api/end_pionts.dart';
import '../../../../core/functions/check_priority_task.dart';
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
        : "${EndPoints.baseUrlEndpoint}${EndPoints.viewImage}${taskEntity
        .image}";
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CustomNetworkImage(
                  image: imageUrl,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
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
                          flex: 3,
                          child: CustomTextWidget(
                              title: taskEntity.title,
                              colorText: Colors.black,
                              size: 16.sp,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(width: 7.w,),
                        ...getPriorityButton(taskEntity.status ?? ''),

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
                        ...getStatusWidget(taskEntity.priority ?? ''),
                        Spacer(),
                        CustomTextWidget(
                            title: formattedDate,
                            colorText: Colors.grey,
                            size: 12.sp,
                            fontWeight: FontWeight.w400
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // EditeAndDeleteButton(
              //   color: Colors.black,
              //   delete: (context) {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return BlocProvider(
              //             create: (context) => getIt.get<TaskOperationsCubit>(),
              //             child: BlocConsumer<
              //                 TaskOperationsCubit,
              //                 TaskOperationStates>(
              //               listener: (context, state) {
              //                 if (state is DeleteTaskSuccess) {
              //                   showToastificationWidget(
              //                       message: state.successDeleteM,
              //                       context: context,
              //                       duration: 3,
              //                       notificationType: ToastificationType.success
              //                   );
              //
              //                 } else if (state is DeleteTaskError) {
              //                   showToastificationWidget(
              //                       message: state.errorM,
              //                       context: context,
              //                       notificationType: ToastificationType.error
              //                   );
              //                 }
              //               },
              //               builder: (context, state) {
              //                 return AlertDialogWidget(
              //                   colorContainer: ColorManager.waitingButton,
              //                   colorIcon: ColorManager.waitingText,
              //                   iconType: IconBroken.Delete,
              //                   title: TextManager.delete,
              //                   items: [
              //                     Padding(
              //                       padding: const EdgeInsets.only(
              //                           bottom: 20),
              //                       child: DeleteAndCancelTaskButton(
              //                         titleButton: TextManager.cancel,
              //                         operation: () {
              //                           context.pop(false);
              //                           context.pop(false);
              //                         },
              //                         isDelete: false,
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.only(
              //                           bottom: 20),
              //                       child: DeleteAndCancelTaskButton(
              //                         operation: () {
              //                           context.read<TaskOperationsCubit>().removeTask(
              //                               taskId: taskEntity.id);
              //                         },
              //                         titleButton: TextManager.delete,
              //                         isDelete: true,
              //                       ),
              //                     ),
              //                   ],
              //                   subTitle: TextManager.deleteMessage,
              //                 );
              //               },
              //             ),
              //           );
              //         }
              //     ).then((value) {
              //       if (value == true) {
              //         if (context.mounted) {
              //           context.read<GetTasksCubit>().getAllTasks(
              //               newGetList: true);
              //           context.pop(true);
              //         }
              //       }
              //     });
              //   },
              //   edite: () {
              //     context.push('/updateTaskView/true', extra: taskEntity);
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }

}