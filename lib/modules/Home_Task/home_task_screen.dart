import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/shared/resources/asset_manager.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../shared/components/constants.dart';
import '../profile/profile_screen.dart';

class HomeTaskScreen extends StatelessWidget {
  const HomeTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
      listener: (context, state) {
        if(state is LogoutSuccessState){
          CherryToast.success(
            title: const Text(' تم تسجيل الخروج بنجاح'),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeTaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
                icon: const Icon(Icons.person_2_outlined),
              ),

              IconButton(
                onPressed: () {
                  singOut(context);
                  // cubit.logOut();
                },
                icon: Icon(Icons.logout_outlined, color: ColorManager.primary,),
              ),
            ],
            title: const Text(
              'Logo',
              style: TextStyle(
                color: Color(0xFF24252C),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(22.0),
              child: Column(
                children: [
                  MyTaskProgress(),
                ],
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: ColorManager.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                onPressed: () {
                },
                child: Image.asset(ImageAssets.qrIcon),
              ),
              const SizedBox(height: 14,),
              FloatingActionButton(
                backgroundColor: ColorManager.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                onPressed: () {
                },
                child: const Icon(Icons.add, color: Colors.white,),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyTaskProgress extends StatelessWidget {
  const MyTaskProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'My Tasks',
          style: TextStyle(
            color: Color(0x9924252C),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

