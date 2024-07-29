import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/resources/string_manager.dart';
import '../../Home_Task/cubit/hometask_cubit.dart';
import 'package:http_parser/http_parser.dart';
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
      emit(UploadImageSuccess(value.data['image']));
    }).catchError((onError) {
      if (onError is DioException) {
        if(onError.response!.statusCode == 401){
          HomeTaskCubit().getRefreshToken().then((value) {
            uploadImage(image: postImage!);
          });
        }
        print(onError.message);
        print(onError.response);
        print(onError.response!.data['message']);
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
  }) async {
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
