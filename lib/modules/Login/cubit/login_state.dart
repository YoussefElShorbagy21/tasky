part of 'login_cubit.dart';


sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ChangePasswordVisibilityState extends LoginState {}


final class SingInLoadingState extends LoginState {}

final class SingInSuccessState extends LoginState {
  final dynamic data;

  SingInSuccessState(this.data);
}

final class SingInErrorState extends LoginState {
  final String error;

  SingInErrorState(this.error);
}
