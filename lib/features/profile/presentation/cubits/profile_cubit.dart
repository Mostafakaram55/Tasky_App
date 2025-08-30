
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/profile/presentation/cubits/profile_states.dart';

import '../../domain/entities/user_entites.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  GetUserDataUseCase getUserDataUseCase;
  ProfileCubit({required this.getUserDataUseCase}):super(InitialProfile());
  static ProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  UserEntity? userEntity;
  Future<void> getProfileData()async{
    emit(LoadingProfile());
    var result= await getUserDataUseCase.callNo();
    result.fold((error){
      emit(ErrorProfile(message: error.message));
    }, (user){
      userEntity=user;
      emit(SuccessProfile(userEntity: user));
    }
    );
  }
}