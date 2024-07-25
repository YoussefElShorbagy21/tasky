import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/resources/string_manager.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of(context);

  //Image
  File? postImage;

  var picker = ImagePicker();

  Future<void> getPostImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage.toString());
      emit(HomePostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomePostImagePickedErrorState());
    }
  }

  Future<void> uploadImage({
    required File image,
}) async {
    emit(UploadImageLoading());
    await DioHelper.postData(
      url: 'upload/image',
      data: FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path),
        }),
    ).then((value) {
      emit(UploadImageSuccess(value.data['image']));
    }).catchError((onError) {
      if (onError is DioException) {
        print(onError.message);
        print(onError.response);
        print(onError.response!.data);
        emit(UploadImageError(onError.response!.data['message']));
      }
    });
  }

  Future<void> addTask({
    required String title ,
    required String desc ,
    required String priority ,
    required String dueDate,
    required String image,
  }) async{
    emit(AddTaskLoading());
    await DioHelper.postData(
      url: AppStrings.endPointTasks,
      data: {
        'title': title,
        'desc': desc,
        'priority': priority,
        'dueDate': dueDate,
        'image': image,
      },
    ).then((value)
    async {
      emit(AddTaskSuccess());
    }
    ).catchError((onError){
      if(onError is DioException) {
        print(onError.message);
        print(onError.response);
        print(onError.response!.data);
        emit(AddTaskError(onError.response!.data['message']));
      }
    });
  }
}
