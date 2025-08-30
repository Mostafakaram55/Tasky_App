import 'package:dartz/dartz.dart';


import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/app_constants.dart';
import '../entities/authentication_entity.dart';
import '../repository/authentication_repository.dart';

class SignInUseCase extends UseCase<AuthenticationEntity,SignInParam>{
  AuthenticationRepository authenticationRepository;
  SignInUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure,AuthenticationEntity>>call([SignInParam? signInParam])async{
    return  await authenticationRepository.signInOperation(
        phone: signInParam!.phone,
        password: signInParam.password
    );
  }
}