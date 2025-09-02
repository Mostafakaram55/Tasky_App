
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/empty_list.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_item_widget.dart';
import '../../../../config/routes/app_routes.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';

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
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  context.push(AppRouter.detailsView,extra:tasks[index]).then((value){
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
              );
            },
            itemCount: tasks.length,
            separatorBuilder: (context,index)=>SizedBox(height: 20.h,),
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