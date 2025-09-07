
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/core/widgets/custom_text_widget.dart';
import 'package:tasky_app/features/home/presentation/cubits/get_task_cubit/get_task_states.dart';
import 'package:toastification/toastification.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/shimmer/shimmer_container_effect.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';
import 'all_task_list_view.dart';
import 'loading_indicator_list_view.dart';
import 'loading_indicator_pagination.dart';

class AllTasksView extends StatelessWidget {
  const AllTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTasksCubit, GetTasksStates>(
        listener: (contextC, state) {
          if(state is GetTasksSuccessState){
            if(state.tasks.isEmpty&&GetTasksCubit.get(context).pageNumber!=1){
              showToastificationWidget(
                  message:TextManager.listEmptyFromPagination,
                  context: context,
                  duration: 3,
                  notificationType:ToastificationType.success
              );
            }
          }
          if (state is GetTasksErrorPaginationState) {
            showToastificationWidget(
                message:state.errorMessage,
                context: context,
                notificationType:ToastificationType.info
            );
          } else if (state is GetTasksErrorState) {
            showToastificationWidget(
                message:state.errorMessage,
                context: context,
                duration: 3,
                notificationType:ToastificationType.error
            );
          }
        },
        builder: (BuildContext context, state) {
          if (state is GetTasksErrorPaginationState || state is GetTasksLoadingPaginationState || state is GetTasksSuccessState) {
            return Column(
              children: [
                Expanded(child: AllTasksListView()),
                if(state is GetTasksLoadingPaginationState )
                  LoadingIndicatorPagination(),
              ],
            );
          } else if (state is GetTasksErrorState) {
            return Center(child: CustomTextWidget(
                title: state.errorMessage,
              fontWeight:FontWeight.w500 ,
              colorText:Colors.black ,
              size:18.sp ,
              maxLines:2 ,
            ));
          } else {
            return const CustomFadingAnimation(child: TasksLoadingIndicator(),);
          }
        }
    );
  }
}