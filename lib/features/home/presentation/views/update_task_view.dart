
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/features/home/presentation/cubits/task_crud_cubit/task_curd_cubit.dart';
import 'package:tasky_app/features/home/presentation/cubits/task_crud_cubit/task_curd_states.dart';


import '../../../../config/icons/icons_broken.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/arrow_left_icon.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../domain/entites/task_entity.dart';
import '../widgets/update_task_view.dart';

class UpdateTaskView extends StatefulWidget {
  const UpdateTaskView({super.key, required this.taskEntity,});
final TaskEntity taskEntity;


  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  @override
  void initState() {
    TaskOperationsCubit.get(context).titleTask.text=widget.taskEntity.title;
    TaskOperationsCubit.get(context).description.text=widget.taskEntity.desc;
    TaskOperationsCubit.get(context).selectedStatus=getStatus(widget.taskEntity.status!);
    TaskOperationsCubit.get(context).selectedPriority=getPriority(widget.taskEntity.priority!);
    super.initState();
  }

  String getStatus (value){
    if( ['inprogress','waiting','finished'].contains(value)){
      return value;
    }else{
      return'inprogress';
    }
  }
  String getPriority (value){
    if( ['low', 'medium', 'high'].contains(value)){
      return value;
    }else{
      return'low';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor:ColorManager.buttonColor,
        title:CustomTextWidget(
            title: 'Edite Task',
            colorText: Colors.white, size: 18.sp,
            fontWeight: FontWeight.w700),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ArrowLeftIcon(
            operation: context.pop,
          ),
        ),
        leadingWidth: 50.w,
      ) ,
      body: BlocBuilder<TaskOperationsCubit, TaskOperationStates>(
    builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: state is EditeTaskLoading||state is UploadTaskImageLoading||state is UploadTaskImageSuccess,
        color: Colors.white,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: UpdateTaskViewBody(taskEntity: widget.taskEntity,));
  },
),
    );
  }
}
