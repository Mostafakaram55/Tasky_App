
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/task_item_widget.dart';

import '../../../../config/routes/app_routes.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import '../cubits/get_task_cubit/get_task_states.dart';
import 'empty_list.dart';

class InProgressListView extends StatefulWidget {
  const InProgressListView({super.key});

  @override
  State<InProgressListView> createState() => _InProgressListViewState();
}

class _InProgressListViewState extends State<InProgressListView> {
  @override
  void initState() {
    GetTasksCubit.get(context).filterTasksList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksStates>(
      builder: (context, state) {
        var inProgressList=GetTasksCubit.get(context).inProgress;
        if(GetTasksCubit.get(context).inProgress.isNotEmpty){
          return ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    context.push(AppRouter.detailsView,extra:inProgressList[index]).then((value){
                      if(value!=null&&value==true){
                        if(context.mounted){
                          context.read<GetTasksCubit>().getAllTasks(newGetList: true);
                        }
                      }
                    });
                  },
                  child: TaskItemWidget(
                    taskEntity:inProgressList[index] ,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.h,),
              itemCount: inProgressList.length
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