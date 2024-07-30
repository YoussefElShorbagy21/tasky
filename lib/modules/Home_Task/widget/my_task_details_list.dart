import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../cubit/hometask_cubit.dart';
import 'my_task_details_item.dart';

class MyTaskDetailsList extends StatelessWidget {
  const MyTaskDetailsList({super.key, required this.pagingController});
  final PagingController<int, dynamic> pagingController ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeTaskCubit.get(context).tasksModel;
        return PagedListView(
          pagingController: pagingController,
          shrinkWrap: true,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, index, taskModel) {
              if (taskModel >= cubit.length) {
                debugPrint('Index out of bounds: $index');
                return const SizedBox.shrink();
              }
              return MyTaskDetailsItem(taskModel: cubit[taskModel],);
            },
            transitionDuration: const Duration(milliseconds: 500),
            animateTransitions: true,
          ),
        ); /*SliverList.builder(
          itemCount: cubit.length,
          itemBuilder: (BuildContext context, int index) {
            return MyTaskDetailsItem(
              taskModel: cubit[index],
            );
          },
        );*/
      },
    );
  }
}