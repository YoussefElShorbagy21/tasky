import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';

import '../../../shared/resources/color_manager.dart';

class MyTaskProgress extends StatefulWidget {
  const MyTaskProgress({super.key});

  @override
  State<MyTaskProgress> createState() => _MyTaskProgressState();
}

class _MyTaskProgressState extends State<MyTaskProgress> {
  final List<String> item = [
    'All',
    'Inpogress',
    'Waiting',
    'Finished'
  ];


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeTaskCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'My Tasks',
              style: TextStyle(
                color: Color(0x9924252C),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.changeIndex(index);
                          if (index == 0) {
                            cubit.getTasks();
                          } else if (index == 1) {
                            cubit.getTasks(status: 'inprogress');
                          } else if (index == 2) {
                            cubit.getTasks(status: 'waiting');
                          } else if (index == 3) {
                            cubit.getTasks(status: 'finished');
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              cubit.i == index
                                  ? ColorManager.primary
                                  : ColorManager.secondary),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        child: Text(
                          item[index],
                          style: TextStyle(
                            color: cubit.i == index
                                ? Colors.white
                                : const Color(
                                0xFF7C7C80),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),

          ],
        );
      },
    );
  }
}