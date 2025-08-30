
import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_pionts.dart';
import '../../domain/entities/user_entites.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource{
  Future<UserEntity>getUserData();
}
class RemoteDataSourceImplementation implements RemoteDataSource{
  ApiService apiService;
  RemoteDataSourceImplementation({required this.apiService});
  @override
  Future<UserEntity>getUserData() async{
    final response=await apiService.get(
      EndPoints.profileEndpoint,
    );
    UserEntity userEntity;
    userEntity=UserModel.fromJson(response.data);
    return userEntity;
  }
}