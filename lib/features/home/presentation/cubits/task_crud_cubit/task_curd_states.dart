
abstract class TaskOperationStates{}

class InitialState extends TaskOperationStates{}
class LoadingUploadTaskState extends TaskOperationStates{}
class UploadTaskDateState extends TaskOperationStates{}
class SelectedPriorityState extends TaskOperationStates{}
class SelectedStatusState extends TaskOperationStates{}
class SuccessUploadTaskState extends TaskOperationStates{
  final String successMessage;
  SuccessUploadTaskState({required this.successMessage});
}
class ErrorUploadTaskState extends TaskOperationStates {
  final String errorMessage;

  ErrorUploadTaskState({required this.errorMessage});

}
class UploadTaskImage extends TaskOperationStates{}

class UploadTaskImageLoading extends TaskOperationStates{}
class UploadTaskImageError extends TaskOperationStates{
  final String errorMassage;

  UploadTaskImageError({ required this.errorMassage});
}
class UploadTaskImageSuccess extends TaskOperationStates{
  final String imagePath;

  UploadTaskImageSuccess({ required this.imagePath});
}

class EditeTaskLoading extends TaskOperationStates{}
class EditeTaskSuccess extends TaskOperationStates{
  final String  successM;
  EditeTaskSuccess({required this.successM});
}
class EditeTaskError extends TaskOperationStates{
  final String errorM;
  EditeTaskError({required this.errorM});
}
class DeleteTaskLoading extends TaskOperationStates{}
class DeleteTaskSuccess extends TaskOperationStates{
  final String  successDeleteM;
  DeleteTaskSuccess({required this.successDeleteM});
}
class DeleteTaskError extends TaskOperationStates{
  final String errorM;
  DeleteTaskError({required this.errorM});
}



