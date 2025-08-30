import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entites.dart';

abstract class ProfileRepository{
  Future<Either<Failure,UserEntity>> getUserData();
}