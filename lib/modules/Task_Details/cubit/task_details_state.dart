part of 'task_details_cubit.dart';

sealed class TaskDetailsState {}

final class TaskDetailsInitial extends TaskDetailsState {}

final class TasksDetailsLoadingState extends TaskDetailsState {}

final class TasksDetailsSuccessState extends TaskDetailsState {}

final class TasksDetailsErrorState extends TaskDetailsState {
  final String message;

  TasksDetailsErrorState(this.message);
}

