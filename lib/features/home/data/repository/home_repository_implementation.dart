import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_app/core/utils/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entites/task_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImplementation implements HomeRepository{
  HomeDataSource homeDataSource;
  HomeRepositoryImplementation({required this.homeDataSource});
  @override
  Future<Either<Failure, TaskEntity>> editeTask({
    required EditeTaskParam editeTaskParam,
  })async {
    try{
      var task=await homeDataSource.editeTask(
          editeTaskParam: editeTaskParam

      );
      return Right(task);
    }catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeTask({
    required String idTask
  })async {
    try{
      var taskDeleteMessage= await homeDataSource.removeTask(taskId: idTask);
      return Right(taskDeleteMessage);
    }catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,String>> uploadTask({
    required UploadTaskParam uploadTaskParam,
  })async {
    try{
      String addTaskMessage=await homeDataSource.uploadTask(
          uploadTaskParam: uploadTaskParam
      );
      return Right(addTaskMessage);
    }catch (e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage({required File image})async {
    try{
      String taskImage=await homeDataSource.uploadTAskImage(image: image);
      return Right(taskImage);
    }catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTask({ required int pageNumber})async {
    try{
      List<TaskEntity> allTasks= await homeDataSource.getAllTask(pageNumber: pageNumber);
      return Right(allTasks);
    }catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,TaskEntity>> getTaskById({required String taskId}) async{
    try{
      var task= await homeDataSource.getTaskById(taskId: taskId);
      return Right(task);
    }catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

