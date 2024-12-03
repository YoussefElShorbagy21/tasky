import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/modules/Task_Details/task_details_screen.dart';
import 'package:tasky/shared/resources/asset_manager.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../shared/components/constants.dart';
import '../Add_Task/add_task_screen.dart';
import '../profile/profile_screen.dart';
import 'widget/my_task_details_list.dart';
import 'widget/my_task_progress.dart';

class HomeTaskScreen extends StatefulWidget {
  const HomeTaskScreen({super.key});

  @override
  State<HomeTaskScreen> createState() => _HomeTaskScreenState();
}

class _HomeTaskScreenState extends State<HomeTaskScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  @override
  void initState() {
    HomeTaskCubit.get(context).pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }


  Future<void> _fetchPage(int pageKey) async {
    var cubit = HomeTaskCubit.get(context);
    try {
      cubit.selectedPageNumber = pageKey;
      await cubit.getTasks();
      final newItems = cubit.tasksModel;
      final state = cubit.state;
      if (state is TasksSuccessState) {
        if (state.isLastPage) {
          cubit.pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          cubit.pagingController.appendPage(newItems, nextPageKey);
        }
      }
      print( cubit.selectedPageNumber);
    } catch (error) {
      cubit.pagingController.error = error;
      print(error);
    }
  }

  @override
  void dispose() {
    HomeTaskCubit.get(context).pagingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCubit, HomeTaskState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            CherryToast.success(
              title: const Text(' تم تسجيل الخروج بنجاح'),
              animationType: AnimationType.fromTop,
            ).show(context);
          }
        },
        builder: (context, state) {
          var cubit = HomeTaskCubit.get(context);
          return RefreshIndicator(
            onRefresh:  () => Future.sync(
                  () => cubit.pagingController.refresh(),
            ),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                    icon: const Icon(Icons.person_2_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      singOut(context);
                      // cubit.logOut();
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: ColorManager.primary,
                    ),
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
              body: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: MyTaskProgress(),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 16,
                          ),
                        ),
                        cubit.tasksModel.isEmpty
                                ? SliverToBoxAdapter(
                                    child: Center(
                                        child: Text("Empty Task",
                                            style: TextStyle(
                                              color: ColorManager.primary,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ))),
                                  )
                                :  SliverFillRemaining(
                          fillOverscroll: true,
                                  child: MyTaskDetailsList(
                                      pagingController: cubit.pagingController,
                                                    ),
                                ),
                      ],
                    ),
                  ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'qr',
                    backgroundColor: ColorManager.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('QR Code Scanner'),
                          content: SizedBox(
                            width: 300,
                            height: 300,
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: (controller) {
                                this.controller = controller;
                                controller.scannedDataStream.listen((event) {
                                  setState(() {
                                    result = event;
                                    print(result!.code);
                                    controller.stopCamera();
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskDetailsScreen(
                                                  id: result!.code.toString(),
                                                )));
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Image.asset(ImageAssets.qrIcon),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  FloatingActionButton(
                    heroTag: 'add',
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddTaskScreen()));
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
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
