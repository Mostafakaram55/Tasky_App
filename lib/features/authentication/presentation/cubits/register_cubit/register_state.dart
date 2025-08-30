import '../../../domain/entities/authentication_entity.dart';

abstract class SignUpStates{}
class InitialState extends SignUpStates{}
class LoadingSignUpState extends SignUpStates{}
class SelectedLevelState extends SignUpStates{}
class ChangeSelectedPhoneNumberStateSignUp extends SignUpStates{}
class ChangeVisiblePasswordSignUp extends SignUpStates{}
class SuccessSignUpState extends SignUpStates{
  AuthenticationEntity userData;
  SuccessSignUpState(this.userData);
}
class ErrorSignUpState extends SignUpStates{
  final String message ;

  ErrorSignUpState( {required this.message});
}