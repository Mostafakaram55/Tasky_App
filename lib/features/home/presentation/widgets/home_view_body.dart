import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/home/presentation/widgets/waiting_task_list_view.dart';
import '../../../../core/utils/app_constants.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import 'all_task_view.dart';
import 'finished_tasks_list_view.dart';
import 'inprogress_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    BlocProvider.of<GetTasksCubit>(context).getAllTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 20.h),
      child: TabBarView(
        controller: AppConstants.tabController,
        children: [
          AllTasksView(),
          InProgressListView(),
          WaitingTaskListView(),
          FinishedTasksListView(),
        ],
      ),
    );
  }
}