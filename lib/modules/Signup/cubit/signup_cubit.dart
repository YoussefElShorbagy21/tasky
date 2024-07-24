import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/resources/string_manager.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;


  void changePasswordVisibility() {
    debugPrint('changePasswordVisibility');
    isPasswordShown = !isPasswordShown;
    suffix =
    isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> userRegister({
    required String username,
    required String password,
    required String phone,
    required int experienceYears,
    required String address,
    required String level ,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
      url: AppStrings.endPointSignUp,
      data:
      {
        "phone" : phone,
        "password" : password,
        "displayName" : username,
        "experienceYears" : experienceYears,
        "address" : address,
        "level" : level
      },
    ).then((value) {
      print(value.data);
      emit(RegisterSuccessState(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(RegisterErrorState(onError.response!.data['message']));
      }
    });
  }
}
