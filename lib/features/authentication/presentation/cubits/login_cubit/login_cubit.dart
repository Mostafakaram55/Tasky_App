import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../domain/use_cases/login_use_case..dart';
import 'login_state.dart';

class SignInCubit extends Cubit<SignInStates>{

  SignInCubit({required this.signInUseCase}):super(InitialState());

  static SignInCubit get(BuildContext context)=>BlocProvider.of(context);

  TextEditingController phoneController =TextEditingController();

  TextEditingController passwordController =TextEditingController();

  var  formLoginKey = GlobalKey<FormState>();

  PhoneNumber phoneNumber=PhoneNumber(countryISOCode: '', countryCode: '', number: '');

  bool isVisiblePassword=true;

  SignInUseCase signInUseCase;

  void changeVisiblePassword(){
    isVisiblePassword=!isVisiblePassword;
    emit(ChangeVisiblePassword());
  }

  void  changeSelectedPhoneNumber({required PhoneNumber phoneNumber}){
    this.phoneNumber=phoneNumber;
    emit(ChangeSelectedPhoneNumberState());
  }

  Future<void> signIn()async{
    emit(LoadingSignInState());
    var result =await signInUseCase.call(SignInParam(
        phone: '${phoneNumber.countryCode}${phoneNumber.number}',
        password: passwordController.text
    ) );
    result .fold(
            (error)=>emit(ErrorSignInState(message: error.message)) ,
            (data)=>emit(SuccessSignInState(data)));
  }
}