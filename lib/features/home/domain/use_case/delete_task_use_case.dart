
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/home_repository.dart';

class DeleteTaskUseCase extends UseCase<String,String>{
  HomeRepository homeRepository;
  DeleteTaskUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, String>> call([String? taskId]) async{
    return await homeRepository.removeTask(idTask: taskId!);
  }

}