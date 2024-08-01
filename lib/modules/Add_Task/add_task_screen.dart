import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:tasky/modules/Add_Task/cubit/add_task_cubit.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../shared/components/components.dart';
import '../../shared/resources/asset_manager.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priorityController = TextEditingController();

  final TextEditingController dueDateController = TextEditingController();

  String priority = '' ;

  String image = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
  listener: (context, state) {
    var cubit = AddTaskCubit.get(context);
    if(state is HomePostImagePickedSuccessState){
      Navigator.pop(context);
      cubit.uploadImage(image: cubit.postImage!);
    }
    else if(state is UploadImageSuccess) {
      CherryToast.success(
        title: const Text('Success Add photo'),
        animationType: AnimationType.fromTop,
      ).show(context);
      image = state.imageUrl;
    }
    else if(state is AddTaskSuccess){
      CherryToast.success(
        title: const Text('Add Success'),
        animationType: AnimationType.fromTop,
      ).show(context);
      Navigator.pop(context);
      cubit.postImage == null ;
      HomeTaskCubit.get(context).getTasks();
    }
    else if(state is AddTaskError){
      CherryToast.error(
        title:  Text(state.error),
        animationType: AnimationType.fromTop,
      ).show(context);
    }
  },
  builder: (context, state) {
    var cubit = AddTaskCubit.get(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add new task',
            style: TextStyle(
              color: Color(0xFF24252C),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.iconBack),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    showSelectPhotoOptions(context,'');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFF5F33E1)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_outlined,color: ColorManager.primary,),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Add Img',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF5F33E1),
                            fontSize: 19,
                            fontWeight: FontWeight.w500,

                          ),
                        )
                      ],
                    ),
                  ),
                ),
                cubit.postImage == null ? const SizedBox() : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            cubit.postImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            onTap: (){
                              cubit.postImage = null;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Task title',
                          style: TextStyle(
                            color: Color(0xFF6E6A7C),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Enter title here...',
                        labelStyle: const TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Task Description',
                          style: TextStyle(
                            color: Color(0xFF6E6A7C),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Enter description here...',
                        labelStyle: const TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Priority',
                          style: TextStyle(
                            color: Color(0xFF6E6A7C),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF0ECFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:TextFormField(
                        controller: priorityController,
                        readOnly: true,
                        style: const TextStyle(
                          color: Color(0xFF5F33E1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Priority is Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          labelStyle: const TextStyle(
                            color: Color(0xFF5F33E1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          prefixIcon: Icon(
                            Icons.flag,
                            color: ColorManager.primary,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: 100,
                              child: DropdownMenuItem(
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'medium',
                                      child: Text('Medium '),
                                    ),
                                    DropdownMenuItem(
                                      value: 'low',
                                      child: Text('Low '),
                                    ),
                                    DropdownMenuItem(
                                      value: 'high',
                                      child: Text('Heigh '),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    priorityController.text = '${value.toString()} Priority';
                                    priority = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Due date',
                          style: TextStyle(
                            color: Color(0xFF6E6A7C),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dueDateController,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'choose due date...',
                        labelStyle: const TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              ).then((onValue) {
                                setState(() {
                                  dueDateController.text = onValue.toString().split(' ')[0];
                                });
                              });
                            });

                          },
                          icon: Icon(
                            Icons.calendar_month,
                            color: ColorManager.primary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 1, color: Color(0xFFBABABA)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                Conditional.single(
                  context: context,
                  conditionBuilder: (context) => state is! AddTaskLoading,
                  widgetBuilder: (context) => ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        cubit.addTask(
                          title: titleController.text,
                          desc: descriptionController.text,
                          priority: priority,
                          dueDate: dueDateController.text,
                          image: image,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add task',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  fallbackBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}


