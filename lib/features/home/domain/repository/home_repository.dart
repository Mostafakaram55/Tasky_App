import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky_app/core/utils/app_constants.dart';

import '../../../../core/errors/failures.dart';
import '../entites/task_entity.dart';

abstract class HomeRepository{
  Future<Either<Failure,String>> uploadTask({
    required UploadTaskParam uploadTaskParam,
  });
  Future<Either<Failure,TaskEntity>> editeTask({
    required EditeTaskParam editeTaskParam,
  });
  Future<Either<Failure,String>> removeTask({ required String idTask});
  Future<Either<Failure,String>> uploadImage({ required File image});
  Future<Either<Failure, List<TaskEntity>>> getAllTask({required int pageNumber});

  Future<Either<Failure,TaskEntity>> getTaskById({required String taskId});

}

