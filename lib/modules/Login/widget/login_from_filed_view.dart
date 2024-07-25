import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/modules/Home_Task/home_task_screen.dart';
import 'package:tasky/modules/Login/cubit/login_cubit.dart';
import 'package:tasky/shared/components/constants.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/resources/color_manager.dart';

class LoginFromFiled extends StatelessWidget {
  LoginFromFiled({super.key});
  final fromKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static String countryCode = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is SingInSuccessState) {
          CherryToast.success(
            title: const Text('تم تسجيل الدخول بنجاح'),
            animationType: AnimationType.fromTop,
          ).show(context);
          await CacheHelper.saveData(key: 'TokenId', value: state.data['access_token']);
          await CacheHelper.saveData(key: 'refreshToken', value: state.data['refresh_token']);
          await CacheHelper.saveData(key: 'ID',value: state.data['_id']);
          navigateFish(context, const HomeTaskScreen());
        }
        else if (state is SingInErrorState) {
          CherryToast.error(
            title: Text(state.error),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF24252C),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    focusedBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  validator: (value) {
                    countryCode = value!.countryCode;
                    if (value.number.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: cubit.isPasswordShown,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password...',
                    suffixIcon: IconButton(
                      onPressed: () {
                       cubit.changePasswordVisibility();
                      },
                      icon: Icon(
                        cubit.suffix,
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),
                    hintText: '**********',

                    focusedBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) => state is! SingInLoadingState,
                  widgetBuilder: (BuildContext context) => Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if(fromKey.currentState!.validate()){
                          print(countryCode + phoneController.text);
                          cubit.userLogin(phone: countryCode + phoneController.text, password: passwordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        maximumSize: const Size(326, 50),
                        minimumSize: const Size(326, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  fallbackBuilder: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
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