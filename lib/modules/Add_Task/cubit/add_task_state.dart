part of 'add_task_cubit.dart';

sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class HomePostImagePickedSuccessState extends AddTaskState {}

final class HomePostImagePickedErrorState extends AddTaskState {}

final class AddTaskLoading extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskError extends AddTaskState {
  final String error;

  AddTaskError(this.error);
}

final class UploadImageLoading extends AddTaskState {}

final class UploadImageSuccess extends AddTaskState {
  final String imageUrl;

  UploadImageSuccess(this.imageUrl);
}

final class UploadImageError extends AddTaskState {
  final String error;

  UploadImageError(this.error);
}
