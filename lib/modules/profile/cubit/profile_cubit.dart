import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/models/UserModel/UserModel.dart';
import 'package:tasky/shared/network/remote/dio_helper.dart';

import '../../../shared/resources/string_manager.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);


  UserModel? userModel;
  Future<void> getUser() async{
    emit(ProfileLoadingState());
    await DioHelper.getDate(
      url: AppStrings.endPointProfile,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ProfileSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(ProfileErrorState(onError.response!.data['message']));
      }
    });
  }
}
