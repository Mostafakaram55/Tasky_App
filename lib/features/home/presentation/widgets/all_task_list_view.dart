
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/config/icons/icons_broken.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/cubits/task_crud_cubit/task_curd_cubit.dart';
import 'package:tasky_app/features/home/presentation/cubits/task_crud_cubit/task_curd_states.dart';
import 'package:tasky_app/features/home/presentation/widgets/empty_list.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_item_widget.dart';
import 'package:toastification/toastification.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import 'alert_dialog_widget.dart';
import 'delete_task_button.dart';

class AllTasksListView extends StatelessWidget {
  const AllTasksListView({super.key});
  @override
  Widget build(BuildContext context) {
    final tasks=context.read<GetTasksCubit>().tasks;
    if(tasks.isNotEmpty){
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollINFO){
          if(scrollINFO.metrics.pixels==scrollINFO.metrics.maxScrollExtent && scrollINFO is ScrollUpdateNotification){
            context.read<GetTasksCubit>().getAllTasks();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: ()async{
            context.read<GetTasksCubit>().getAllTasks(newGetList: true);
          },
          child: BlocListener<TaskOperationsCubit, TaskOperationStates>(
           listener: (context, state) {
              if(state is DeleteTaskSuccess){
              showToastificationWidget(
               message: TextManager.successDeleteMessage,
               context: context,
               notificationType:ToastificationType.success
           );
              context.read<GetTasksCubit>().getAllTasks(newGetList: true);
              context.pop(true);
           }
         },
            child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return Slidable(
                key: ValueKey(tasks[index].id),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.push('/updateTaskView', extra: tasks[index]);
                      },
                      backgroundColor: ColorManager.buttonColor,
                      foregroundColor: Colors.white,
                      icon: IconBroken.Edit,
                      label: TextManager.edit,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context){
                        // showDialog(
                        //     context: context,
                        //     builder: (context){
                        //       return AlertDialogWidget(
                        //           items: [
                        //             Padding(
                        //               padding: const EdgeInsets.only(
                        //                   bottom: 20),
                        //               child: DeleteAndCancelTaskButton(
                        //                 titleButton: TextManager.cancel,
                        //                 operation: (){
                        //                   context.pop(false);
                        //                 },
                        //                 isDelete: false,
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.only(
                        //                   bottom: 20),
                        //               child: DeleteAndCancelTaskButton(
                        //                 operation: () {
                        //                  context.pop(true);
                        //                 },
                        //                 titleButton: TextManager.delete,
                        //                 isDelete: true,
                        //               ),
                        //             ),
                        //           ],
                        //           title:TextManager.delete,
                        //           subTitle: TextManager.deleteMessage,
                        //           iconType: IconBroken.Delete
                        //       );
                        //     }
                        //     ).then((value){
                        //       if(value==true){
                        //         if(context.mounted){
                        //           context.read<TaskOperationsCubit>().removeTask(taskId: tasks[index].id);
                        //         }
                        //       }else{
                        //       }
                        // });
                        context.read<TaskOperationsCubit>().removeTask(taskId: tasks[index].id);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: IconBroken.Delete,
                      label: TextManager.delete,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: (){
                    context.push(AppRouter.detailsView,extra:tasks[index],).then((value){
                      if(value!=null&&value==true){
                        if(context.mounted){
                          context.read<GetTasksCubit>().getAllTasks(newGetList: true);
                        }
                      }
                    });
                  },
                  child: TaskItemWidget(
                    taskEntity:tasks[index] ,
                  ),
                ),
              );
            },
            itemCount: tasks.length,
            separatorBuilder: (context,index)=>SizedBox(height: 20.h,),
          ),
           ),
        ),
      );
    }else{
      return EmptyList(
        title: TextManager.listEmpty,
      );
    }
  }
}