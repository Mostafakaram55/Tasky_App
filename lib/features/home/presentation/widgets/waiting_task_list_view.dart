import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/empty_list.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_item_widget.dart';

import '../../../../config/routes/app_routes.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import '../cubits/get_task_cubit/get_task_states.dart';

class WaitingTaskListView extends StatefulWidget {
  const WaitingTaskListView({super.key});

  @override
  State<WaitingTaskListView> createState() => _WaitingTaskListViewState();
}

class _WaitingTaskListViewState extends State<WaitingTaskListView> {
  @override
  void initState() {
    GetTasksCubit.get(context).filterTasksList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksStates>(
      builder: (context, state) {
        var waitingList=GetTasksCubit.get(context).waiting;
        if( GetTasksCubit.get(context).waiting.isNotEmpty){
          return ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    AppRouter.navigateTo(AppRouter.detailsView,extra:waitingList[index]);
                  },
                  child: TaskItemWidget(
                    taskEntity:waitingList[index] ,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.h,),
              itemCount: waitingList.length
          );
        }else{
          return EmptyList(
            title: TextManager.listEmpty,
          );
        }
      },
    );
  }
}
