part of 'hometask_cubit.dart';


sealed class HomeTaskState {}

final class HomeTaskInitial extends HomeTaskState {}

final class LoadingLogoutSate extends HomeTaskState {}

final class LogoutSuccessState extends HomeTaskState {
  final String message;

  LogoutSuccessState(this.message);
}

final class LogoutErrorState extends HomeTaskState {
  final String message;

  LogoutErrorState(this.message);
}
