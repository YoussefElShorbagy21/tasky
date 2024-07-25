part of 'add_task_cubit.dart';

sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class HomePostImagePickedSuccessState extends AddTaskState {}

final class HomePostImagePickedErrorState extends AddTaskState {}
