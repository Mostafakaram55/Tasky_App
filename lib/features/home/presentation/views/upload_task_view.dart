import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../config/icons/icons_broken.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/arrow_left_icon.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_widget.dart' show CustomTextWidget;
import '../cubits/task_crud_cubit/task_curd_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_states.dart';
import '../widgets/upload_tas_view_body.dart';

class UploadTaskView extends StatefulWidget {
  const UploadTaskView({super.key});

  @override
  State<UploadTaskView> createState() => _UploadTaskViewState();
}

class _UploadTaskViewState extends State<UploadTaskView> {
  @override
  void initState() {
    context.read<TaskOperationsCubit>().selectedPriority='medium';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskOperationsCubit,TaskOperationStates>(
      builder: (context,state){
        return ModalProgressHUD(
          inAsyncCall:  state is LoadingUploadTaskState || state is UploadTaskImageLoading ||state is UploadTaskImageSuccess,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
              appBar:AppBar(
                backgroundColor: ColorManager.buttonColor,
                title: CustomTextWidget(
                    title: 'Add New Task',
                    colorText: Colors.white, size: 18.sp, fontWeight: FontWeight.w700),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ArrowLeftIcon(
                    operation: context.pop,
                  ),
                ),
                leadingWidth: 50.w,
              ),
              body: UploadTaskViewBody()
          ),
        );
      },
    );
  }
}