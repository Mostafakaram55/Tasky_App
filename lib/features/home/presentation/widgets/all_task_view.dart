
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/cubits/get_task_cubit/get_task_states.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/shimmer/shimmer_container_effect.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import 'all_task_list_view.dart';
import 'loading_indicator_list_view.dart';

class AllTasksView extends StatelessWidget {
  const AllTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTasksCubit, GetTasksStates>(
        listener: (contextC, state) {
          if(state is GetTasksSuccessState){
            if(state.tasks.isEmpty){
              customSnackBar(
                  context, CustomSnackBar.info(message: TextManager.listEmpty));
            }
          }
          if (state is GetTasksErrorPaginationState) {
            customSnackBar(
                context, CustomSnackBar.error(message: state.errorMessage));
          } else if (state is GetTasksErrorState) {
            customSnackBar(
                context, CustomSnackBar.error(message: state.errorMessage));
          }
        },
        builder: (BuildContext context, state) {
          if (state is GetTasksErrorPaginationState || state is GetTasksLoadingPaginationState || state is GetTasksSuccessState) {
            return AllTasksListView();
          } else if (state is GetTasksErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const CustomFadingAnimation(child: TasksLoadingIndicator(),);
          }
        }
    );
  }
}