
import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_pionts.dart';
import '../../domain/entities/authentication_entity.dart';
import '../models/authentication_model.dart';


abstract  class AuthenticationDataSource{
  Future<AuthenticationEntity> signInUser({
    String? phone,
    String?password
  });
  Future<AuthenticationEntity> signUpUser({
    String? phone,
    String? password,
    String? displayName,
    String? experienceYears,
    String? address,
    String? level,
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
    String? phone,
    String? password,
    String? displayName,
    String? experienceYears,
    String? address,
    String? level,
  }) async{
    final response= await apiService.post(
        EndPoints.singUpEndpoint,
        data: {
          if (phone != null) 'phone': phone,
          if (password != null) 'password': password,
          if(displayName!=null) 'displayName':displayName,
          if (experienceYears != null) 'experienceYears': experienceYears,
          if (address != null) 'address': address,
          if(level!=null) 'level':level,
        }
    );
    AuthenticationEntity user;
    user=AuthenticationModel.fromJson(response.data);
    return user;
  }

}