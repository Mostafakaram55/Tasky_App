
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/empty_list.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_item_widget.dart';
import '../../../../config/routes/app_routes.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';

class AllTasksListView extends StatelessWidget {
  const AllTasksListView({super.key});
  @override
  Widget build(BuildContext context) {
    final tasks=GetTasksCubit.get(context).tasks;
    if(tasks.isNotEmpty){
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollINFO){
          if(scrollINFO.metrics.pixels==scrollINFO.metrics.maxScrollExtent && scrollINFO is ScrollUpdateNotification){
            context.read<GetTasksCubit>().getAllTasks();
          }
          return true;
        },
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                AppRouter.navigateTo(AppRouter.detailsView,extra:tasks[index]);
              },
              child: TaskItemWidget(
                taskEntity:tasks[index] ,
              ),
            );
          },
          itemCount: tasks.length,
          separatorBuilder: (context,index)=>SizedBox(height: 20.h,),
        ),
      );
    }else{
      return EmptyList(
        title: TextManager.listEmpty,
      );
    }

  }
}