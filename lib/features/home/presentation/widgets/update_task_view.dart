import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/config/routes/app_routes.dart';
import 'package:tasky_app/core/functions/show_snak_bar.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/core/widgets/custom_button_widget.dart';
import 'package:tasky_app/features/home/presentation/cubits/task_crud_cubit/task_curd_states.dart';
import 'package:tasky_app/features/home/presentation/views/home_view.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_priority.dart';
import 'package:tasky_app/features/home/presentation/widgets/select_task_status.dart';
import 'package:tasky_app/features/home/presentation/widgets/update_task_image.dart';
import 'package:toastification/toastification.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/api/end_pionts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../domain/entites/task_entity.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';

class UpdateTaskViewBody extends StatelessWidget {
  const UpdateTaskViewBody({
    super.key,
    required this.taskEntity,
  });

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        taskEntity.image.contains('http')
            ? taskEntity.image
            : "${EndPoints.baseUrlEndpoint}${EndPoints.viewImage}${taskEntity.image}";
    return BlocConsumer<TaskOperationsCubit, TaskOperationStates>(
      listener: (context, state) {
        if (state is UploadTaskImageSuccess) {
          context.read<TaskOperationsCubit>().editeTask(
            image: taskEntity.image,
            idTask: taskEntity.id,
            user: taskEntity.user,
          ).then((value){
            if (context.mounted) {
              context.pushReplacement(AppRouter.kHomeView);
            }
          });
        } else if (state is UploadTaskImageError) {
          showToastificationWidget(
              message: TextManager.uploadImage,
              context: context,

              notificationType:ToastificationType.error
          );
        } else if (state is EditeTaskSuccess) {
          showToastificationWidget(
              message: TextManager.successMessage,
              context: context,

              notificationType:ToastificationType.success
          );
        } else if (state is EditeTaskError) {
          showToastificationWidget(
              message:TextManager.errorMessage,
              context: context,

              notificationType:ToastificationType.error
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: context.read<TaskOperationsCubit>().formUpdateTaskKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UpdateTaskImage(imageUrl: imageUrl),
                  SizedBox(height: 10.h),
                  CustomTextWidget(
                    title: TextManager.taskTitle,
                    colorText: ColorManager.titleFormAddTask,
                    size: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormFiled(
                    textEditingController:
                        context.read<TaskOperationsCubit>().titleTask,
                    textInputType: TextInputType.text,
                    obscureText: false,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'please enter task title';
                      }
                      return null;
                    },
                    hintText: 'Enter new title here...',
                  ),
                  SizedBox(height: 16.h),
                  CustomTextWidget(
                    title: TextManager.taskDescription,
                    colorText: ColorManager.titleFormAddTask,
                    size: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormFiled(
                    maxLines: 4,
                    textEditingController:
                        context.read<TaskOperationsCubit>().description,
                    textInputType: TextInputType.text,
                    obscureText: false,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'please enter task description';
                      }
                      return null;
                    },
                    hintText: 'Enter new description here...',
                  ),
                  SizedBox(height: 16.h),
                  CustomTextWidget(
                    title: TextManager.priority,
                    colorText: ColorManager.titleFormAddTask,
                    size: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  const SelectTaskStatus(),
                  SizedBox(height: 16.h),
                  CustomTextWidget(
                    title: TextManager.status,
                    colorText: ColorManager.titleFormAddTask,
                    size: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  const SelectTaskPriority(),
                  SizedBox(height: 16.h),
                  CustomButton(
                    onPressed: () {
                      if (context
                          .read<TaskOperationsCubit>()
                          .formUpdateTaskKey
                          .currentState!
                          .validate()) {
                        if (context.read<TaskOperationsCubit>().imageTask !=
                            null) {
                          context.read<TaskOperationsCubit>().uploadTaskImage();
                        } else {
                          context
                              .read<TaskOperationsCubit>()
                              .editeTask(
                                idTask: taskEntity.id,
                                image: taskEntity.image,
                                user: taskEntity.user,
                              )
                              .then((value) {
                                if (context.mounted) {
                                  context.pushReplacement(AppRouter.kHomeView);
                                 }
                              });
                        }
                      }
                    },
                    titleButton: TextManager.editeTask,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
