import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart' show UseCase;
import '../../../../core/utils/app_constants.dart';
import '../entities/authentication_entity.dart';
import '../repository/authentication_repository.dart';

class SignUpUseCase extends UseCase<AuthenticationEntity,SignUpParam>{
  AuthenticationRepository authenticationRepository;
  SignUpUseCase({required this.authenticationRepository});
  @override

  Future<Either<Failure,AuthenticationEntity>>call([SignUpParam? signUpParams])async {
    return await authenticationRepository.signUpOperation(
      phone: signUpParams!.phone,
      password: signUpParams.password,
      displayName: signUpParams.displayName,
      experienceYears: signUpParams.experienceYears,
      address: signUpParams.address,
      level: signUpParams.level,
    );
  }
}