import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/authentication_entity.dart';
import '../../domain/repository/authentication_repository.dart';
import '../data_source/authentication_remote_data_source.dart';

class  AuthenticationRepositoryImplementation implements  AuthenticationRepository{
  AuthenticationDataSource authenticationDataSource;
  AuthenticationRepositoryImplementation({ required this.authenticationDataSource});
  @override
  Future<Either<Failure, AuthenticationEntity>> signInOperation({
    required String phone,
    required String password
  })async {
    try {
      var user=await authenticationDataSource.signInUser(
        password: password,
        phone: phone,
      );
      return Right(user);
    }catch (e) {
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> signUpOperation({
    required SignUpParam signUpParam,
  }) async{
    try{
      var user =await authenticationDataSource.signUpUser(
        signIpParam:signUpParam ,

      );
      return Right(user);
    }catch (e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}