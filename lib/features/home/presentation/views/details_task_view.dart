import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/arrow_left_icon.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../domain/entites/task_entity.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_states.dart';
import '../widgets/edite_and_delete_button.dart';
import '../widgets/task_details_view_body.dart';

class DetailsTaskView extends StatelessWidget {
  const DetailsTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    final task = GoRouterState.of(context).extra as TaskEntity;
    return BlocConsumer<TaskOperationsCubit,TaskOperationStates>(
      listener: (context,state){
        if(state is EditeTaskSuccess){
          return  customSnackBar(context, CustomSnackBar.success(message: state.successM));
        }else{ if(state is DeleteTaskSuccess) {
          return customSnackBar(context,  CustomSnackBar.success(message: state.successDeleteM));
        }
        }
      },
      builder: (context, state) {
        return  ModalProgressHUD(
          inAsyncCall:  state is DeleteTaskLoading,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator:  const CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.buttonColor,
              centerTitle: false,
              title: CustomTextWidget(
                  title: TextManager.taskDetails,
                  colorText: Colors.white,
                  size: 16.sp,
                  fontWeight: FontWeight.w700
              ),
              leading: Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: ArrowLeftIcon(
                  operation: context.pop
                ),
              ),
              leadingWidth: 50.w,
              actions: [
                EditeAndDeleteButton(
                  delete: () {
                    context.read<TaskOperationsCubit>().removeTask(taskId: task.id).then((value){
                     if(context.mounted){
                      context.pop(true);
                      context.pop(true);
                     }
                    });
                  },
                  edite: () {
                    context.push(AppRouter.updateTaskView,extra:task).then((value){
                      if(value!=null&&value==true){
                        if(context.mounted){
                          context.read<GetTasksCubit>().getAllTasks(newGetList: true);
                        }
                      }
                    });
                  //  AppRouter.navigateTo(AppRouter.updateTaskView,extra: task);
                  },
                ),
              ],
            ),
            body: DetailsTaskViewBody(
              taskEntity: task,
            ),
          ),
        );
      },
    );
  }
}
