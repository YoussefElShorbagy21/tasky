import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasky/models/TasksModel/TasksModel.dart';
import 'package:tasky/shared/network/local/cache_helper.dart';
import 'package:tasky/shared/network/remote/dio_helper.dart';
import 'package:tasky/shared/resources/string_manager.dart';

import '../../../shared/components/constants.dart';
import 'package:http_parser/http_parser.dart';


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

  String status = '';
  int selectedPageNumber = 1;
 List<TasksModel> tasksModel = [];
  final PagingController<int, TasksModel> pagingController =
  PagingController(firstPageKey: 1);


  Future<void> getTasks() async{
    emit(TasksLoadingState());
    String url = '${AppStrings.endPointTasks}?page=$selectedPageNumber';
    if (status.isNotEmpty) {
      url += '&status=$status';
    }
    await DioHelper.getDate(
      url: url,
    ).then((value) {
      final List<TasksModel> newItems = (value.data as List).map((e) => TasksModel.fromJson(e)).toList();
      if (selectedPageNumber == 1) {
        tasksModel = newItems;
        pagingController.itemList = tasksModel;
      }
      else {
        tasksModel.addAll(newItems);
        pagingController.appendPage(newItems, selectedPageNumber + 1);
      }

      if (newItems.isEmpty) {
        emit(TasksSuccessState(isLastPage: true));
      }
      else {
        emit(TasksSuccessState(isLastPage: false));
      }
    }).catchError((onError) {
      if (onError is DioException) {
        if(onError.response!.statusCode == 401){
          getRefreshToken().then((value) {
            getTasks();
          });
        }
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        pagingController.error = onError.message;
        emit(TasksErrorState(onError.response!.data['message']));
      }
    });
  }

  Future<void> updateStatusAndRefresh(int index) async {
    switch (index) {
      case 0:
        status = '';
        break;
      case 1:
        status = 'inprogress';
        break;
      case 2:
        status = 'waiting';
        break;
      case 3:
        status = 'finished';
        break;
    }
    selectedPageNumber = 1;
    pagingController.itemList = [];
    tasksModel.clear();
    await getTasks();
    emit(UpdateStatusAndRefreshState());
  }

  Future<void> deleteTask({
    required String taskId,
  }) async {
    emit(DeleteTaskLoadingState());
    await DioHelper.deleteData(
      url: '${AppStrings.endPointTasks}/$taskId',
    ).then((value)
    {
      emit(DeleteTaskSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        if(onError.response!.statusCode == 401){
        getRefreshToken().then((value) {
            deleteTask(taskId: taskId);
          });
        }
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


  File? postImage;

  var picker = ImagePicker();

  Future<void> getPostImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage.toString());
      emit(HomePostImagePickedSuccessStateEdit());
    } else {
      print('No image selected');
      emit(HomePostImagePickedErrorStateEdit());
    }
  }

  Future<void> uploadImage({
    required File image,
  }) async {
    emit(UploadImageLoadingHome());
    final String mimeType = 'image/${image.path.split('/').last.split('.').last}';
    FormData formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(
        image.readAsBytesSync(),
        filename: image.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      ),
    });
    await DioHelper.postData(
      url: 'upload/image',
      data: formData,
    ).then((value) {
      emit(UploadImageSuccessHome(value.data['image']));
    }).catchError((onError) {
      if (onError is DioException) {
        if(onError.response!.statusCode == 401){
         getRefreshToken().then((value) {
            uploadImage(image: postImage!);
          });
        }
        print(onError.message);
        print(onError.response);
        print(onError.response!.data['message']);
        emit(UploadImageErrorHome(onError.response!.data['message']));
      }
    });
  }


  Future<void> updateTask({
    required String image,
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
        "image": image,
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
        if(onError.response!.statusCode == 401){
          getRefreshToken().then((value) {
            updateTask(
              image: image,
              title: title,
              desc: desc,
              priority: priority,
              status: status,
              id: id,
            );
          });
        }
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(UpdateTaskErrorState(onError.response!.data['message']));
      }
    });
  }


}
