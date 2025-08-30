import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/app_constants.dart';
import '../repository/home_repository.dart';

class UploadTaskUseCase extends UseCase<String,UploadTaskParam>{
  HomeRepository homeRepository;
  UploadTaskUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, String>> call([UploadTaskParam? uploadTaskParam])async {
    return await homeRepository.uploadTask(
        image: uploadTaskParam!.image,
        title: uploadTaskParam.title,
        desc: uploadTaskParam.desc,
        priority: uploadTaskParam.priority,
        dueDate: uploadTaskParam.dueDate
    );
  }

}