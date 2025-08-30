import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/task_entity.dart';
import '../../../domain/use_case/get_all_task_use_case.dart';
import '../../../domain/use_case/get_task_by_id_use_case.dart';
import 'get_task_states.dart';

class GetTasksUseCase{
  GetAllTaskUseCase getAllTaskUseCase;
  GetTaskById getTaskById;
  GetTasksUseCase({required this.getAllTaskUseCase,required this.getTaskById});
}
class GetTasksCubit extends Cubit<GetTasksStates>{
  GetTasksUseCase getTasksUseCase;
  GetTasksCubit({required this.getTasksUseCase}):super(GetTasksInitialState());
  static GetTasksCubit get(BuildContext context)=>BlocProvider.of(context);
  List<TaskEntity>tasks=[];

  List<TaskEntity>inProgress=[];
  List<TaskEntity>waiting=[];
  List<TaskEntity>finished=[];
  bool hasMoreData = true;

  int pageNumber=1;

  Future<void>getAllTasks()async{
    if(pageNumber==1){
      emit(GetTasksLoadingState());
    }else{
      emit(GetTasksLoadingPaginationState());
    }
    var result=await getTasksUseCase.getAllTaskUseCase.call(pageNumber);
    result.fold((error){
      emit(GetTasksErrorState(errorMessage: error.message));
    },(tasks){
      if(pageNumber==1){
        this.tasks=tasks;
        pageNumber++;
      }else if(tasks.isNotEmpty){
        this.tasks.addAll(tasks);// معني كده اني ضيف عليها علشان طلعت فيها data
        pageNumber++;
      }
      emit(GetTasksSuccessState(tasks:tasks));
    });
  }

  void filterTasksList(){
    inProgress=[];
    waiting=[];
    finished=[];
    for(TaskEntity task  in tasks){
      switch(task.status.toLowerCase().replaceAll('', '')){
        case 'inprogress':
          inProgress.add(task);
        case 'waiting':
          waiting.add(task);
        case 'finished':
          finished.add(task);
      }
    }
  }
  TaskEntity? taskById ;
  Future<void>getTaskById({required String taskId})async{
    emit(GetTaskByIdLoading());
    var task=await getTasksUseCase.getTaskById.call(taskId);
    task.fold((error){
      emit(GetTaskByIdError(errorMessage: error.toString()));
    }, (task){
      taskById = task;
      emit(GetTaskByIdSuccess(taskById: task));
    });
  }
}




// Future<void> getTaskById({required String taskId}) async {
//   emit(GetTaskByIdLoadingState());
//   Either<Failure, TaskEntity> result =
//   await tasksCubitParams.getTaskByIdUseCase.call(taskId);
//   result.fold((error) {
//     emit(GetTaskByIdFailureState(error.error));
//   }, (task) {
//     taskById = task;
//     emit(GetTaskByIdSuccessState(task));
//   });
// }