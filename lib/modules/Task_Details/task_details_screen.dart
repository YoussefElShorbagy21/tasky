import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../shared/resources/asset_manager.dart';
import '../Edit_Task/edit_task_screen.dart';
import 'cubit/task_details_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => TaskDetailsCubit()..getTasksDetails(id: id),
  child: BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TaskDetailsCubit.get(context);
          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getTasksDetails(id: id);
            },
            child: Scaffold(
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
                      if (value == 'edit') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            EditTaskScreen(task: cubit.tasksModelDetails!,)));
                      }
                      else if (value == 'delete') {
                        HomeTaskCubit.get(context).deleteTask(taskId: cubit.tasksModelDetails?.id ?? '');
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.more_vert),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                            value: 'edit',
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                               EditTaskScreen(task: cubit.tasksModelDetails!,)));
                            },
                            child: const Opacity(
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
                            HomeTaskCubit.get(context).deleteTask(taskId: cubit.tasksModelDetails?.id ?? '');
                          },
                        ),
                      ];
                    },
                  ),
                ],
              ),
              body: cubit.tasksModelDetails == null ? const Center(child: CircularProgressIndicator()):
              SingleChildScrollView(
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
                            cubit.tasksModelDetails?.title ?? '',
                            style: const TextStyle(
                              color: Color(0xFF24252C),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Text(
                            cubit.tasksModelDetails?.desc ?? '',
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
                                        cubit.tasksModelDetails?.createdAt!.split('T')[0] ?? '',
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
                                    cubit.tasksModelDetails?.status ?? '',
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
                                    cubit.tasksModelDetails?.priority ?? '',
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
                              data: cubit.tasksModelDetails?.id ?? '',
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
            ),
          );
        },
      ),
);
  }
}
