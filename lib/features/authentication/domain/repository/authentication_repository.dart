import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_constants.dart';
import '../entities/authentication_entity.dart';

abstract class AuthenticationRepository{
  Future<Either<Failure,AuthenticationEntity>>signInOperation({
    required String phone,
    required String password,
  });
  Future<Either<Failure,AuthenticationEntity>>signUpOperation({
    required   SignUpParam signUpParam,

  });
}