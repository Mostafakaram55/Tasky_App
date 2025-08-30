
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entites.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_remote_data-source.dart';

class ProfileRepositoryImplementation implements ProfileRepository{
  RemoteDataSource remoteDataSource;
  ProfileRepositoryImplementation({required this.remoteDataSource});
  @override
  Future<Either<Failure,UserEntity>> getUserData() async{
    try{
      var result=await remoteDataSource.getUserData();
      return Right(result);
    }catch(error){
      if(error is DioException){
        return Left(ServerFailure.fromDioError(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}