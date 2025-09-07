import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:toastification/toastification.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../config/icons/icons_broken.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/arrow_left_icon.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../domain/entites/task_entity.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_states.dart';
import '../widgets/alert_dialog_widget.dart';
import '../widgets/delete_task_button.dart';
import '../widgets/edite_and_delete_button.dart';
import '../widgets/task_details_view_body.dart';

class DetailsTaskView extends StatelessWidget {
  const DetailsTaskView({super.key, required this.whereFrom});
  final bool whereFrom;
  @override
  Widget build(BuildContext context) {
    final task = GoRouterState.of(context).extra as TaskEntity;
    return BlocConsumer<TaskOperationsCubit,TaskOperationStates>(
      listener: (context,state){
        if(state is DeleteTaskSuccess) {
          showToastificationWidget(
              message:state.successDeleteM,
              context: context,
              notificationType:ToastificationType.success
          );
        }else if(state is DeleteTaskError){
          showToastificationWidget(
              message:state.errorM,
              context: context,
              notificationType:ToastificationType.error
          );
        }
      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.buttonColor,
            centerTitle: false,
            title: CustomTextWidget(
                title: TextManager.taskDetails,
                colorText: Colors.white,
                size: 18.sp,
                fontWeight: FontWeight.w700
            ),
            leading: Padding(
              padding:  EdgeInsets.only(left: 20.w),
              child: ArrowLeftIcon(
                operation: (){
                  if(whereFrom==true){
                    context.pop(true);
                    context.pop(true);
                  }
                  context.pop();
                }
              ),
            ),
            leadingWidth: 50.w,
            actions: [
              EditeAndDeleteButton(
                delete: (newContext) {
                  showDialog(
                      context: newContext,
                      builder: (newContext){
                        return ModalProgressHUD(
                          inAsyncCall:  state is DeleteTaskLoading,
                          color: Colors.white,
                          opacity: 0.5,
                          child: AlertDialogWidget(
                            colorContainer: ColorManager.waitingButton,
                            colorIcon: ColorManager.waitingText,
                            iconType:IconBroken.Delete ,
                            title: TextManager.delete,
                            items: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: DeleteAndCancelTaskButton(
                                  titleButton: TextManager.cancel,
                                  operation: (){
                                    context.pop();
                                    context.pop();
                                  },
                                  isDelete: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: DeleteAndCancelTaskButton(
                                  operation: (){
                                    context.read<TaskOperationsCubit>().removeTask(taskId: task.id).then((value){
                                      if(whereFrom==true){
                                        if(context.mounted){
                                          context.pop(true);
                                          context.pop(true);
                                          context.pop(true);
                                          context.pop(true);
                                        }
                                      }
                                      if(context.mounted){
                                        context.pop(true);
                                        context.pop(true);
                                        context.pop(true);
                                      }
                                    });
                                  },
                                  titleButton:TextManager.delete,
                                  isDelete: true,
                                ),
                              ),
                            ],
                            subTitle: TextManager.deleteMessage,
                          ),
                        );
                      }
                  );
                },
                edite: () {
                  context.push('/updateTaskView',extra:task,).then((value){
                    if(value!=null&&value==true){
                      if(context.mounted){
                        context.read<GetTasksCubit>().getAllTasks(newGetList: true);
                      }
                    }
                  });
                },
              ),
            ],
          ),
          body: DetailsTaskViewBody(
            taskEntity: task,
          ),
        );
      },
    );
  }
}
