import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/authentication_entity.dart';

abstract class AuthenticationRepository{
  Future<Either<Failure,AuthenticationEntity>>signInOperation({
    required String phone,
    required String password,
  });
  Future<Either<Failure,AuthenticationEntity>>signUpOperation({
    required   String phone,
    required  String password,
    required   String displayName,
    required  String experienceYears,
    required  String address,
    required  String level,
  });
}