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

final class RefreshTokenLoadingState extends HomeTaskState {}

final class RefreshTokenSuccessState extends HomeTaskState {}

final class RefreshTokenErrorState extends HomeTaskState {
  final String message;

  RefreshTokenErrorState(this.message);
}


final class UpdateTaskLoadingState extends HomeTaskState {}

final class UpdateTaskSuccessState extends HomeTaskState {}

final class UpdateTaskErrorState extends HomeTaskState {
  final String message;

  UpdateTaskErrorState(this.message);
}

final class UploadImageLoadingHome extends HomeTaskState {}

final class UploadImageSuccessHome extends HomeTaskState {
  final String image;

  UploadImageSuccessHome(this.image);
}

final class UploadImageErrorHome extends HomeTaskState {
  final String message;

  UploadImageErrorHome(this.message);
}

final class HomePostImagePickedSuccessStateEdit extends HomeTaskState {}

final class HomePostImagePickedErrorStateEdit extends HomeTaskState {}