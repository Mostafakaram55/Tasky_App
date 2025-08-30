import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entites/task_entity.dart';
import '../repository/home_repository.dart';

class GetTaskById extends UseCase<TaskEntity,String>{
  HomeRepository homeRepository;
  GetTaskById({required this.homeRepository});
  @override
  Future<Either<Failure, TaskEntity>> call([String? taskId]) async{
    return  await homeRepository.getTaskById(taskId: taskId!);
  }

}