import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
