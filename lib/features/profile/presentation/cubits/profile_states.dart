import '../../domain/entities/user_entites.dart';

abstract class ProfileStates{}
class InitialProfile extends ProfileStates{}
class LoadingProfile extends ProfileStates{}
class SuccessProfile extends ProfileStates{
  final UserEntity userEntity;
  SuccessProfile({required this.userEntity});
}
class ErrorProfile extends ProfileStates{
  final String message;
  ErrorProfile({required this.message});
}