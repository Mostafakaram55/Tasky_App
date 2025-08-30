import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky_app/features/authentication/domain/use_cases/login_use_case..dart';
import 'package:tasky_app/features/home/data/data_source/home_remote_data_source.dart';
import 'package:tasky_app/features/home/data/repository/home_repository_implementation.dart';
import 'package:tasky_app/features/profile/data/repository/profile_repository_implementation.dart';
import '../../features/authentication/data/data_source/authentication_remote_data_source.dart';
import '../../features/authentication/data/repository/authentication_repository_implementation.dart';
import '../../features/authentication/domain/use_cases/signup_use_case.dart';
import '../../features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import '../../features/home/domain/use_case/delete_task_use_case.dart';
import '../../features/home/domain/use_case/edite_task_use_case.dart';
import '../../features/home/domain/use_case/get_all_task_use_case.dart';
import '../../features/home/domain/use_case/get_task_by_id_use_case.dart';
import '../../features/home/domain/use_case/upload_image_use_case.dart';
import '../../features/home/domain/use_case/upload_task_use_case.dart';
import '../../features/home/presentation/cubits/get_task_cubit/get_task_cubit.dart';
import '../../features/home/presentation/cubits/task_crud_cubit/task_curd_cubit.dart';
import '../../features/profile/data/data_source/profile_remote_data-source.dart';
import '../../features/profile/domain/use_cases/get_user_data_use_case.dart';
import '../../features/profile/presentation/cubits/profile_cubit.dart' show ProfileCubit;
import '../api/api_services.dart';
import '../api/app_interceptors.dart';


final getIt=GetIt.instance;
void setUp(){

  getIt.registerSingleton<ApiInterceptor>(ApiInterceptor(Dio()));

  getIt.registerSingleton<ApiService>(ApiService(getIt<ApiInterceptor>()));

  getIt.registerSingleton<AuthenticationRepositoryImplementation>(
    AuthenticationRepositoryImplementation(
      authenticationDataSource :AuthenticationDataSourceImplementation(
          getIt.get<ApiService>()
      ),
    ),

  );
  getIt.registerSingleton<ProfileRepositoryImplementation>(ProfileRepositoryImplementation(remoteDataSource: RemoteDataSourceImplementation(apiService: getIt.get<ApiService>())));

  getIt.registerFactory<ProfileCubit>(()=>ProfileCubit(
    getUserDataUseCase: GetUserDataUseCase(
        profileRepo: getIt.get<ProfileRepositoryImplementation>()),
  ),
  );
  getIt.registerSingleton<HomeRepositoryImplementation>(
      HomeRepositoryImplementation(
          homeDataSource: HomeDataSourceImplementation(apiService: getIt.get<ApiService>()))
  );
  getIt.registerFactory<TaskOperationsCubit>(()=>TaskOperationsCubit(
    taskOperationCubitParams:TaskOperationCubitParams(
      deleteTaskUseCase: DeleteTaskUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
      editeTaskUseCase: EditeTaskUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>(),),
      uploadTaskUseCase: UploadTaskUseCase(homeRepository:getIt.get<HomeRepositoryImplementation>(),),
      uploadTaskImageUseCase:UploadImageUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
    ),
  ),
  );
  getIt.registerFactory<GetTasksCubit>(()=>GetTasksCubit(
    getTasksUseCase:GetTasksUseCase(
        getTaskById: GetTaskById(homeRepository:getIt.get<HomeRepositoryImplementation>() ),
        getAllTaskUseCase: GetAllTaskUseCase(
          homeRepository:getIt.get<HomeRepositoryImplementation>(),
        )
    ),
  ),
  );

  getIt.registerFactory<SignInCubit>(()=>SignInCubit(
    signInUseCase: SignInUseCase(
        authenticationRepository:getIt.get<AuthenticationRepositoryImplementation>()
    ),
  ),
  );
  getIt.registerFactory<SignUPCubit>(()=>SignUPCubit(
    signUpUseCase: SignUpUseCase(
        authenticationRepository:getIt.get<AuthenticationRepositoryImplementation>()
    ),
  ),
  );

}