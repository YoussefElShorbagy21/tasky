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

final class ChangeIndexState extends HomeTaskState {}

final class TasksLoadingState extends HomeTaskState {}

final class TasksSuccessState extends HomeTaskState {}

final class TasksErrorState extends HomeTaskState {
  final String message;

  TasksErrorState(this.message);
}

final class DeleteTaskLoadingState extends HomeTaskState {}

final class DeleteTaskSuccessState extends HomeTaskState {}

final class DeleteTaskErrorState extends HomeTaskState {
  final String message;

  DeleteTaskErrorState(this.message);
}
