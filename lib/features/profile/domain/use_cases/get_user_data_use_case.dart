
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user_entites.dart';
import '../repository/profile_repository.dart';

class GetUserDataUseCase extends UseCaseNoParam<UserEntity>{
  ProfileRepository profileRepo;
  GetUserDataUseCase({required this.profileRepo});
  @override
  Future<Either<Failure,UserEntity>> callNo()async{
    return await profileRepo.getUserData();
  }
}