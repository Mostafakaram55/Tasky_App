import '../../../domain/entities/authentication_entity.dart';

abstract class SignInStates{}
class InitialState extends SignInStates{}
class LoadingSignInState extends SignInStates{}
class ChangeSelectedPhoneNumberState extends SignInStates{}
class ChangeVisiblePassword extends SignInStates{}
class SuccessSignInState extends SignInStates{
  AuthenticationEntity userData;
  SuccessSignInState(this.userData);
}
class ErrorSignInState extends SignInStates{
  final String message ;

  ErrorSignInState( {required this.message});
}