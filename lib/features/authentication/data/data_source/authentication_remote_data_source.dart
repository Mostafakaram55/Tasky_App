
import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_pionts.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/authentication_entity.dart';
import '../models/authentication_model.dart';


abstract  class AuthenticationDataSource{
  Future<AuthenticationEntity> signInUser({
    String? phone,
    String?password
  });
  Future<AuthenticationEntity> signUpUser({
    SignUpParam? signIpParam,
  });
}

class AuthenticationDataSourceImplementation implements AuthenticationDataSource{
  ApiService apiService;
  AuthenticationDataSourceImplementation(this.apiService);
  @override

  Future<AuthenticationEntity> signInUser({
    String? phone ,
    String? password,
  }) async{
    final response=await apiService.post(
      EndPoints.singInEndpoint,
      formData: false,
      data:{
        if (phone != null) 'phone': phone,
        if (password != null) 'password': password,
      } ,
    );
    AuthenticationEntity user;
    user=AuthenticationModel.fromJson(response.data);
    return user;
  }
  @override
  Future<AuthenticationEntity> signUpUser({
     SignUpParam? signIpParam,
  }) async{
    final response= await apiService.post(
        EndPoints.singUpEndpoint,
        data: {
          'phone': signIpParam!.phone,
          'password': signIpParam.password,
          'displayName':signIpParam.displayName,
          'experienceYears':signIpParam. experienceYears,
          'address':signIpParam. address,
          'level':signIpParam.level,
        }
    );
    AuthenticationEntity user;
    user=AuthenticationModel.fromJson(response.data);
    return user;
  }

}