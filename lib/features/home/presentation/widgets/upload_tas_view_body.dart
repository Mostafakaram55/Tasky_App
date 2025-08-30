import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/home/presentation/widgets/upload_image_task.dart';
import 'package:tasky_app/features/home/presentation/widgets/upload_task_text_fileds.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_states.dart';

class UploadTaskViewBody extends StatelessWidget {
  const UploadTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskOperationsCubit,TaskOperationStates>(
      listener: (context,state){
        if(state is UploadTaskImageSuccess){
          context.read<TaskOperationsCubit>().uploadTask();
        }else if(state is UploadTaskImageError){
          customSnackBar(context,CustomSnackBar.error(message: state.errorMassage));
        }else if(state is SuccessUploadTaskState){
          customSnackBar(context,CustomSnackBar.success(message: state.successMessage));
          Navigator.pop(context);
        }else if(state is ErrorUploadTaskState){
          customSnackBar(context,CustomSnackBar.error(message: state.errorMessage));
        }
      },
      builder: (context,state){
        return Form(
          key: context.read<TaskOperationsCubit>().formUploadTaskKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  UploadImageTask(),
                  SectionTaskFileds(),
                  CustomButton(
                    onPressed: (){
                      if(context.read<TaskOperationsCubit>().formUploadTaskKey.currentState!.validate()){
                        if(context.read<TaskOperationsCubit>().imageTask!=null ){
                          context.read<TaskOperationsCubit>().uploadTaskImage();
                        }else{
                          customSnackBar(context,CustomSnackBar.error(message: 'please select image'));
                        }
                      }
                    },
                    titleButton: 'Add Task',
                    isIcon: false,
                  ),
                  SizedBox(height: 30.h,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}