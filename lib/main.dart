import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/modules/Add_Task/cubit/add_task_cubit.dart';
import 'package:tasky/modules/Home_Task/cubit/hometask_cubit.dart';
import 'package:tasky/modules/Login/cubit/login_cubit.dart';
import 'package:tasky/modules/Signup/cubit/signup_cubit.dart';
import 'package:tasky/shared/bloc_observer.dart';
import 'package:tasky/shared/components/constants.dart';
import 'package:tasky/shared/network/local/cache_helper.dart';
import 'package:tasky/shared/network/remote/dio_helper.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import 'modules/Home_Task/home_task_screen.dart';
import 'modules/Login/login_screen.dart';
import 'modules/Task_Details/cubit/task_details_cubit.dart';
import 'modules/profile/cubit/profile_cubit.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/start_screen/start_screen_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.inti();
  await CacheHelper.init();
  Widget widget;
  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'TokenId');
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeTaskScreen();
    } else {
      widget = const LoginScreen();
    }
  }
  else {
    widget = const StartScreenView();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()..getUser()),
        BlocProvider<HomeTaskCubit>(create: (context) => HomeTaskCubit()..getTasks()),
        BlocProvider<AddTaskCubit>(create: (context) => AddTaskCubit()),
        BlocProvider<TaskDetailsCubit>(create: (context) => TaskDetailsCubit()),
      ],
      child: MaterialApp(
        title: 'Tasky',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primary),
          useMaterial3: true,
        ),
        home: SplashScreen(startWidget: startWidget,),
      ),
    );
  }
}
