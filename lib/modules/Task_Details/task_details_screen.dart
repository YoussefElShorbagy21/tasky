import 'package:cherry_toast/resources/arrays.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../models/TasksModel/TasksModel.dart';
import '../../shared/resources/asset_manager.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.taskModel});

  final TasksModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
      listener: (context, state) {
        var cubit = HomeTaskCubit.get(context);
        if(state is DeleteTaskSuccessState){
          CherryToast.success(
            title: const Text('Task Deleted Successfully'),
            animationType: AnimationType.fromTop,
          ).show(context);
          Navigator.pop(context);
          if(cubit.i == 0){
            cubit.getTasks();
          }else if(cubit.i == 1){
            cubit.getTasks(status: 'inprogress');
          }else if(HomeTaskCubit.get(context).i == 2){
            cubit.getTasks(status: 'waiting');
          }else if(HomeTaskCubit.get(context).i == 3){
            cubit.getTasks(status: 'finished');
          }
        } else if(state is DeleteTaskErrorState){
          CherryToast.error(
            title: Text(state.message),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeTaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Task Details',
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
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {} else if (value == 'delete') {}
                },
                icon: const Icon(Icons.more_vert),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                        value: 'edit',
                        child: Opacity(
                          opacity: 0.87,
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xFF00060D),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: const Opacity(
                        opacity: 0.87,
                        child: Text(
                          'Delete',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFFF7D53),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        cubit.deleteTask(taskId: taskModel.id ?? '');
                      },
                    ),
                  ];
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(ImageAssets.imageDetails),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        taskModel.title ?? '',
                        style: const TextStyle(
                          color: Color(0xFF24252C),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Text(
                        taskModel.desc ?? '',
                        style: const TextStyle(
                          color: Color(0x9924252C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF0ECFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'End Date',
                                style: TextStyle(
                                  color: Color(0xFF6E6A7C),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,

                                ),
                              ),

                              Row(
                                children: [
                                  Text(
                                    taskModel.createdAt!.split('T')[0],
                                    style: const TextStyle(
                                      color: Color(0xFF24252C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.calendar_month,
                                    color: ColorManager.primary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF0ECFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                taskModel.status ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF5F33E1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,

                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_drop_down,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF0ECFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag,
                                color: ColorManager.primary,
                              ),
                              Text(
                                taskModel.priority ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF5F33E1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,

                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_drop_down,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: QrImageView(
                          data: taskModel.id ?? '',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
