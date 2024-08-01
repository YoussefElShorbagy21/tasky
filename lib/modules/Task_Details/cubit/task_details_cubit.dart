import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/TasksModel/TasksModel.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/resources/string_manager.dart';
import '../../Home_Task/cubit/hometask_cubit.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit() : super(TaskDetailsInitial());

  static TaskDetailsCubit get(context) => BlocProvider.of(context);

  TasksModel? tasksModelDetails ;
  Future<void> getTasksDetails({
    required String id,
  }) async {
    emit(TasksDetailsLoadingState());
    await DioHelper.getDate(
      url: '${AppStrings.endPointTasks}/$id' ,
    ).then((value) {
      tasksModelDetails = TasksModel.fromJson(value.data);
      emit(TasksDetailsSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        if(onError.response!.statusCode == 401){
          HomeTaskCubit().getRefreshToken().then((value) {
            getTasksDetails(id: id);
          });
        }
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(TasksDetailsErrorState(onError.response!.data['message']));
      }
    });
  }
}
