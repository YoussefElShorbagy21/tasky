import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/resources/string_manager.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;


  void changePasswordVisibility() {
    debugPrint('changePasswordVisibility');
    isPasswordShown = !isPasswordShown;
    suffix =
    isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> userLogin({
    required String phone,
    required String password,
  }) async {
    emit(SingInLoadingState());
    await DioHelper.postData(
      url: AppStrings.endPointLogin,
      data:
      {
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(SingInSuccessState(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(SingInErrorState(onError.response!.data['message']));
      }
    });
  }
}
