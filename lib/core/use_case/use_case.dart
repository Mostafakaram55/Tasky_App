import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCase<Type,Pram> {

  Future<Either<Failure,Type>> call([Pram param]);

}

abstract class UseCaseNoParam<Type>{
  Future<Either<Failure,Type>> callNo();

}