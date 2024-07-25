import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:tasky/models/TasksModel/TasksModel.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/modules/Task_Details/cubit/task_details_cubit.dart';
import 'package:tasky/modules/Task_Details/task_details_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/resources/asset_manager.dart';
import '../../shared/resources/color_manager.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final TasksModel task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priorityController = TextEditingController();

  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.title ?? '';
    descriptionController.text = widget.task.desc ?? '';
    priorityController.text = widget.task.priority ?? '';
    statusController.text = widget.task.status ?? '' ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
  listener: (context, state) {
    if (state is UpdateTaskSuccessState) {
      CherryToast.success(
        title: const Text('Edit Success'),
        animationType: AnimationType.fromTop,
      ).show(context);
      HomeTaskCubit.get(context).getTasks();
      Navigator.pop(context);
    }
  },
  builder: (context, state) {
    var cubit = HomeTaskCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task Details',
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    showSelectPhotoOptions(context);
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
                                    priorityController.text = value.toString();
                                   /* priority = value.toString();*/
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
                          'Status',
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
                        controller: statusController,
                        readOnly: true,
                        style: const TextStyle(
                          color: Color(0xFF5F33E1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Status is Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Status',
                          labelStyle: const TextStyle(
                            color: Color(0xFF5F33E1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              width: 150,
                              child: DropdownMenuItem(
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'inprogress',
                                      child: Text('InProgress'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'waiting',
                                      child: Text('Waiting'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'finished',
                                      child: Text('Finished'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    statusController.text = value.toString();
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
                  height: 28,
                ),
                Conditional.single(
                  context: context,
                  conditionBuilder: (context) => state is! UpdateTaskLoadingState,
                  widgetBuilder: (context) => ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        cubit.updateTask(
                          title: titleController.text,
                          desc: descriptionController.text,
                          priority: priorityController.text,
                          status: statusController.text,
                            id: widget.task.id ?? ''
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
                          'Edit task',
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
