import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/app_constants.dart';
import '../entites/task_entity.dart';
import '../repository/home_repository.dart';

class EditeTaskUseCase extends UseCase<TaskEntity,EditeTaskParam>{
  HomeRepository homeRepository;
  EditeTaskUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, TaskEntity>> call([EditeTaskParam? editeTask])async {
    return await homeRepository.editeTask(
        image: editeTask!.image,
        title: editeTask.title,
        desc: editeTask.desc,
        priority:editeTask. priority,
        status: editeTask.status,
        user:editeTask. user,
        idTask: editeTask.idTask
    );
  }
}