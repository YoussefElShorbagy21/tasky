import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/models/TasksModel/TasksModel.dart';
import 'package:tasky/shared/network/local/cache_helper.dart';
import 'package:tasky/shared/network/remote/dio_helper.dart';
import 'package:tasky/shared/resources/string_manager.dart';

import '../../../shared/components/constants.dart';


part 'hometask_state.dart';

class HomeTaskCubit extends Cubit<HomeTaskState> {
  HomeTaskCubit() : super(HomeTaskInitial());

  static HomeTaskCubit get(context) => BlocProvider.of(context);



  Future<void> logOut() async {
    emit(LoadingLogoutSate());
    token = CacheHelper.getData(key: 'TokenId');
    print(token);
    await DioHelper.postData(
      url: AppStrings.endPointLogout,
      data: {
        "token" : token
      },
    ).then((value) {
      print(value.data);
      emit(LogoutSuccessState(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(LogoutErrorState(onError.response!.data['message']));
      }
    });
  }

  int i = 0 ;

  void changeIndex(int index){
    i = index;
    emit(ChangeIndexState());
  }

 List<TasksModel> tasksModel = [];
  Future<void> getTasks({
    String? status,
}) async{
    emit(TasksLoadingState());
    String url = "${AppStrings.endPointTasks}?status=$status";
    await DioHelper.getDate(
      url: status == null ? AppStrings.endPointTasks : url,
    ).then((value) {
      tasksModel = (value.data as List).map((e) => TasksModel.fromJson(e)).toList();
      emit(TasksSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        if(onError.response!.statusCode == 401){
          getRefreshToken().then((value) {
            getTasks();
          });
        }
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(TasksErrorState(onError.response!.data['message']));
      }
    });
  }



  Future<void> deleteTask({
    required String taskId,
  }) async {
    emit(DeleteTaskLoadingState());
    await DioHelper.deleteData(
      url: '${AppStrings.endPointTasks}/$taskId',
    ).then((value)
    {
      print(i);
      emit(DeleteTaskSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(DeleteTaskErrorState(onError.response!.data['message']));
      }
    });
  }


  Future<void> getRefreshToken() async{
    emit(RefreshTokenLoadingState());
    refreshToken = CacheHelper.getData(key: 'refreshToken');
    await DioHelper.getDate(
      url: 'auth/refresh-token?token=$refreshToken',
    ).then((value) {
      CacheHelper.saveData(key: 'TokenId', value: value.data['access_token']);
      emit(RefreshTokenSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.statusCode.toString());
        debugPrint(onError.response!.data['message']);
        emit(RefreshTokenErrorState(onError.response!.data['message']));
      }
    });
  }


  Future<void> updateTask({
    required String title,
    required String desc,
    required String priority,
    required String status,
    required String id,
  }) async{
    emit(UpdateTaskLoadingState());
    uid = CacheHelper.getData(key: 'ID');
    await DioHelper.putData(
      url: '${AppStrings.endPointTasks}/$id',
      data: {
        "image": "path.png",
        "title": title,
        "desc": desc,
        "priority": priority,
        "status": status,
        "user": uid,
      }
    ).then((value) {
      print(value.data);
      emit(UpdateTaskSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(UpdateTaskErrorState(onError.response!.data['message']));
      }
    });
  }
}
