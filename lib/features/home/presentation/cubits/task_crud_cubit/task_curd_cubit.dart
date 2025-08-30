import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/features/home/presentation/cubits/task_crud_cubit/task_curd_states.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../domain/use_case/delete_task_use_case.dart';
import '../../../domain/use_case/edite_task_use_case.dart';
import '../../../domain/use_case/upload_image_use_case.dart';
import '../../../domain/use_case/upload_task_use_case.dart';


class TaskOperationCubitParams{
  UploadTaskUseCase uploadTaskUseCase;
  UploadImageUseCase uploadTaskImageUseCase;
  EditeTaskUseCase editeTaskUseCase;
  DeleteTaskUseCase deleteTaskUseCase;
  TaskOperationCubitParams({
    required this.uploadTaskUseCase,
    required this.uploadTaskImageUseCase,
    required this.editeTaskUseCase,
    required this.deleteTaskUseCase
  });
}

class TaskOperationsCubit extends Cubit<TaskOperationStates>{
  TaskOperationCubitParams taskOperationCubitParams;
  TaskOperationsCubit({required this.taskOperationCubitParams}):super(InitialState());
  static  TaskOperationsCubit get(BuildContext context)=>BlocProvider.of(context);

  DateTime dateTask=DateTime.now();
  final TextEditingController titleTask=TextEditingController();
  final TextEditingController  description=TextEditingController();
  final TextEditingController  deuData=TextEditingController();



  var  formUploadTaskKey = GlobalKey<FormState>();
  var  formUpdateTaskKey = GlobalKey<FormState>();
  //selected Priority Task
  String selectedPriority='';

  void selectedPriorityTask({required String selectedPriority}){
    this.selectedPriority=selectedPriority;
    emit(SelectedPriorityState());
  }

  String selectedStatus='';
  void selectedStatusTask({required String selectedStatus}){
    this.selectedStatus=selectedStatus;
    emit(SelectedStatusState());
  }

//upload DueDateTask
  Future<void> uploadTaskDate(BuildContext context) async {
    DateTime?newDate=await showDatePicker(
      initialDate: dateTask,
      context: context,
      firstDate: DateTime(2000),
      lastDate:DateTime(2100),
    );
    if (newDate != null) {
      deuData.text = DateFormat('yyyy-MM-dd').format(newDate);
      emit(UploadTaskDateState());
    }
  }

  // upload image to Api
  File? imageTask;
  String uploadImagePath='';
  final picker=ImagePicker();

  Future uploadTaskImageFromGallery()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      imageTask=File(pickedFile.path);
    }
    emit(UploadTaskImage());
  }

  Future uploadTaskImageFromCamera()async{
    final pickedFile=await picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null){
      imageTask=File(pickedFile.path);
    }
    emit(UploadTaskImage());
  }

  Future<void>uploadTaskImage()async{
    emit(UploadTaskImageLoading());
    var image= await taskOperationCubitParams.uploadTaskImageUseCase.call(
        imageTask!
    );
    image.fold((error){
      if(error.message.contains('Opps')){
        emit(UploadTaskImageError(errorMassage: 'image size is large'));
      }else{
        emit(UploadTaskImageError(errorMassage: error.message));
      }
    }, (image)async{
      uploadImagePath=image;
      emit(UploadTaskImageSuccess(imagePath: image));
    });
  }

  // upload task
  Future<void>uploadTask()async{
    emit(LoadingUploadTaskState());
    final result=await taskOperationCubitParams.uploadTaskUseCase.call(
      UploadTaskParam(
        title: titleTask.text,
        priority: selectedPriority,
        desc: description.text,
        image: uploadImagePath,
        dueDate: deuData.text,
      ),
    );
    result.fold((error){
      emit(ErrorUploadTaskState(errorMessage: error.message));
    }, (message){
      emit(SuccessUploadTaskState(successMessage:message));
    }
    );
  }

  Future<void>editeTask({
    required String image,
    required String user,
    required String idTask,
  })async{
    emit(EditeTaskLoading());
    var task=await taskOperationCubitParams.editeTaskUseCase.call(
      EditeTaskParam(
        image: imageTask != null ? uploadImagePath : image,
        title: titleTask.text,
        desc: description.text,
        priority:selectedPriority,
        user: user,
        status: selectedStatus,
        idTask: idTask,
      ),
    );
    task.fold((error){
      emit(EditeTaskError(errorM: error.message));
    }, (task){
      emit(EditeTaskSuccess(successM:'Edite Task Successful'));
    });
  }


  Future<void>removeTask({required String taskId})async{
    emit(DeleteTaskLoading());
    var task=await taskOperationCubitParams.deleteTaskUseCase.call(taskId);
    task.fold((error){
      emit(DeleteTaskError(errorM: error.message));
    }, (taskDeleteMessage){
      emit(DeleteTaskSuccess(successDeleteM: taskDeleteMessage));
    });
  }

}