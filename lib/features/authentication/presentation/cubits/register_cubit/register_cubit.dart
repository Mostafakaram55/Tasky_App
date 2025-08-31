import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky_app/features/authentication/presentation/cubits/register_cubit/register_state.dart' show ChangeSelectedPhoneNumberStateSignUp, ChangeVisiblePasswordSignUp, ErrorSignUpState, InitialState, LoadingSignUpState, SelectedLevelState, SignUpStates, SuccessSignUpState;

import '../../../../../core/utils/app_constants.dart';
import '../../../domain/use_cases/signup_use_case.dart';

class SignUPCubit extends Cubit<SignUpStates>{
  SignUpUseCase signUpUseCase;
  SignUPCubit({ required this.signUpUseCase}):super(InitialState());
  static SignUPCubit get(BuildContext context)=>BlocProvider.of(context);
  TextEditingController levelController=TextEditingController();

  TextEditingController phoneController=TextEditingController();

  TextEditingController addressController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController experienceYearsController=TextEditingController();

  TextEditingController displayNameController=TextEditingController();

  PhoneNumber phoneNumber=PhoneNumber(countryISOCode: '', countryCode: '', number: '');

  List<String> levels=['fresh', 'junior', 'midLevel', 'senior'];

  bool isVisiblePasswordS=true;

  var  formRegisterKey = GlobalKey<FormState>();
  String selectedValue='fresh';

  void selectedLevel({ required String selectedValue}){
    this.selectedValue=selectedValue;
    emit(SelectedLevelState());
  }
  void changeSelectPhoneNumber({ required PhoneNumber phoneNumber}){
    this.phoneNumber=phoneNumber;
    emit(ChangeSelectedPhoneNumberStateSignUp());
  }
  void changeVisiblePasswordS(){
    isVisiblePasswordS=!isVisiblePasswordS;
    emit(ChangeVisiblePasswordSignUp());
  }


  Future<void> signUp()async{
    emit(LoadingSignUpState());
    var result= await signUpUseCase.call(SignUpParam(
      phone: '${phoneNumber.countryCode}${phoneNumber.number}',
      password:passwordController.text ,
      level: selectedValue,
      experienceYears: experienceYearsController.text,
      displayName: displayNameController.text,
      address:addressController.text ,
    ));
    result.fold((error)=>emit(ErrorSignUpState(message: error.message)),
          (data)=>emit(SuccessSignUpState(data)),
    );
  }

}