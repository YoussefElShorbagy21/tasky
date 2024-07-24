import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/hometask_cubit.dart';
import 'my_task_details_item.dart';

class MyTaskDetailsList extends StatelessWidget {
  const MyTaskDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeTaskCubit
            .get(context)
            .tasksModel;
        return SliverList.builder(
          itemCount: cubit.length,
          itemBuilder: (BuildContext context, int index) {
            return MyTaskDetailsItem(
              taskModel: cubit[index],
            );
          },
        );
      },
    );
  }
}