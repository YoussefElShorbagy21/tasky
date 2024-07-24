part of 'signup_cubit.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class ChangePasswordVisibilityState extends SignupState {}

class RegisterLoadingState extends SignupState {}

class RegisterSuccessState extends SignupState {
  dynamic successModel ;
  RegisterSuccessState(this.successModel) ;
}

class RegisterErrorState extends SignupState {
  String? errorModel ;
  RegisterErrorState(this.errorModel) ;
}