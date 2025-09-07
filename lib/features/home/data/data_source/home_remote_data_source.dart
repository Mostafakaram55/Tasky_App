import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_pionts.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entites/task_entity.dart';
import '../models/task_model.dart';


abstract class  HomeDataSource{
  Future<String>uploadTask({
    required UploadTaskParam uploadTaskParam
  });
  Future<TaskEntity>editeTask({
    required EditeTaskParam editeTaskParam,

  });
  Future<String>removeTask({
    required String taskId
  });
  Future<String>uploadTAskImage({
    required File image
  });
  Future<List<TaskEntity>>getAllTask({ required int pageNumber});
  Future<TaskEntity>getTaskById({ required String taskId});
}



class HomeDataSourceImplementation implements HomeDataSource{
  ApiService apiService;
  HomeDataSourceImplementation({required this.apiService});
  @override
  Future<TaskEntity> editeTask({
    required EditeTaskParam editeTaskParam,
  })async {
    var response=await apiService.put(
        EndPoints.editeEndpoint+editeTaskParam.idTask,
        data: {
          'image':editeTaskParam.image,
          'title':editeTaskParam.title,
          'desc':editeTaskParam.desc,
          'priority':editeTaskParam.priority,
          'status':editeTaskParam.status,
          'user':editeTaskParam.user,
        }
    );
    TaskEntity taskEntity;
    taskEntity=TaskModel.fromMap(response);
    return taskEntity;
  }

  @override
  Future<String> removeTask({
    required String taskId
  }) async{
    await apiService.delete(
      EndPoints.deleteEndpoint+taskId,
    );
    return 'Delete Task successfully';
  }

  @override
  Future<String> uploadTask({
  required UploadTaskParam uploadTaskParam,
  }) async{
    await apiService.post(
        EndPoints.createEndpoint,
        formData: false,
        data:{
          'image':uploadTaskParam.image,
          'title':uploadTaskParam.title,
          'desc':uploadTaskParam.desc,
          'priority':uploadTaskParam.priority,
          'dueDate':uploadTaskParam.dueDate,
        }
    ) ;
    return 'Add Task successfully';
  }

  @override
  Future<String> uploadTAskImage({required File image}) async{
    FormData formData=FormData();
    formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
          contentType: DioMediaType.parse("image/${image.path.split('.').length}"),
        )));
    final response=await apiService.post(
        EndPoints.uploadImage,
        formData: false,
        data: formData
    );
    return response.data['image'];
  }

  @override
  Future<List<TaskEntity>> getAllTask({
    required int pageNumber
  }) async{
    Response data= await apiService.get(
        EndPoints.getAllTask,
        queryParm:{
          'page':pageNumber,
        }
    );
    List<TaskEntity>tasks=(data.data as List<dynamic>).map((task){
      return TaskModel.fromMap(task);
    }).toList();

    // for(var taskMap in response.data){
    //   tasks.add(TaskModel.fromMap(taskMap));
    // }
    return tasks;
  }

  @override
  Future<TaskEntity> getTaskById({required String taskId})async {
    Response data=await apiService.get('${EndPoints.getTaskBYID}$taskId');
    TaskEntity taskEntity;
    taskEntity=TaskModel.fromMap(data.data);
    return taskEntity;
  }

}

