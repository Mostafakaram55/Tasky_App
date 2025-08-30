import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/task_entity.dart';

abstract class HomeRepository{
  Future<Either<Failure,String>> uploadTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate
  });
  Future<Either<Failure,TaskEntity>> editeTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String status,
    required String user,
    required String idTask,
  });
  Future<Either<Failure,String>> removeTask({ required String idTask});
  Future<Either<Failure,String>> uploadImage({ required File image});
  Future<Either<Failure, List<TaskEntity>>> getAllTask({required int pageNumber});

  Future<Either<Failure,TaskEntity>> getTaskById({required String taskId});

}

