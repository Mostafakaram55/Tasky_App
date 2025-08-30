import '../../../domain/entites/task_entity.dart';

abstract class GetTasksStates{}
class GetTasksInitialState extends GetTasksStates{}
class GetTasksLoadingState extends GetTasksStates{}
class GetTasksSuccessState extends GetTasksStates{
  final List<TaskEntity>tasks;

  GetTasksSuccessState({required this.tasks});
}
class GetTasksErrorState extends GetTasksStates{
  final String errorMessage;
  GetTasksErrorState({required this.errorMessage});
}
class GetTasksLoadingPaginationState extends GetTasksStates{}
class GetTasksErrorPaginationState extends GetTasksStates{
  final String errorMessage;
  GetTasksErrorPaginationState({required this.errorMessage});


}
class GetTaskByIdLoading extends GetTasksStates{}
class GetTaskByIdSuccess extends GetTasksStates{
  final TaskEntity taskById;
  GetTaskByIdSuccess({required this.taskById});
}
class GetTaskByIdError extends GetTasksStates{
  final String errorMessage;
  GetTaskByIdError({required this.errorMessage});
}
