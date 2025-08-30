import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_pionts.dart';
import '../../domain/entites/task_entity.dart';
import '../models/task_model.dart';


abstract class  HomeDataSource{
  Future<String>uploadTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate
  });
  Future<TaskEntity>editeTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String status,
    required String user,
    required String idTask,
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
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String status,
    required String user,
    required String idTask,
  })async {
    var response=await apiService.put(
        EndPoints.editeEndpoint+idTask,
        data: {
          'image':image,
          'title':title,
          'desc':desc,
          'priority':priority,
          'status':status,
          'user':user,
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
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate
  }) async{
    await apiService.post(
        EndPoints.createEndpoint,
        formData: false,
        data:{
          'image':image,
          'title':title,
          'desc':desc,
          'priority':priority,
          'dueDate':dueDate,
        }
    ) ;
    return 'Add Task successfully';
  }

  @override
  Future<String> uploadTAskImage({required File image}) async{
    FormData formData=FormData();// علشان ابعتها بالطريقة اللي الخادم يفهمها
    formData.files.add(MapEntry(// نبعتها في شكل map
        'image',
        await MultipartFile.fromFile(
          image.path,// مسار الملف
          filename: image.path.split('/').last,// اسم الملف يتم استخراجة من الملف
          contentType: DioMediaType.parse("image/${image.path.split('.').length}"),//نوع الملف MIME (مثل image/jpeg أو image/png)
        )));
// send image(formData) to api
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

