
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entites/task_entity.dart';
import '../repository/home_repository.dart';

class GetAllTaskUseCase extends UseCase<List<TaskEntity>,int>{
  HomeRepository homeRepository;
  GetAllTaskUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, List<TaskEntity>>> call([int? pageNumber]) async{
    return await homeRepository.getAllTask(pageNumber: pageNumber!);
  }

}