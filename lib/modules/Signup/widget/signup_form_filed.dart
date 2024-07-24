
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/modules/Signup/cubit/signup_cubit.dart';
import 'package:tasky/shared/network/local/cache_helper.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/resources/color_manager.dart';
import '../../Home_Task/home_task_screen.dart';

class SignupFormFiled extends StatelessWidget {
  SignupFormFiled({super.key});
  final fromKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experienceYears = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static String countryCode = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          CherryToast.success(
            title: Text(' ${state.successModel['displayName']}  تم تسجيل الدخول بنجاح'),
            animationType: AnimationType.fromTop,
          ).show(context);
          await CacheHelper.saveData(key: 'TokenId', value: state.successModel['access_token']);
          navigateFish(context, const HomeTaskScreen());
        }else if (state is RegisterErrorState) {
          CherryToast.error(
            title: Text(state.errorModel!),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cubit = SignupCubit.get(context);
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
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name...',
                    labelStyle: const TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),
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
                  height: 15,
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
                  height: 15,
                ),

                TextFormField(
                  controller: experienceYears,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Experience Years is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Years of experience....',
                    labelStyle: const TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),
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
                  height: 15,
                ),

                TextFormField(
                  controller: levelController,
                  readOnly: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Choose experience Level';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Choose experience Level',
                    labelStyle: const TextStyle(
                      color: Color(0xFF2F2F2F),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
                                value: 'fresh',
                                child: Text('fresh '),
                              ),
                              DropdownMenuItem(
                                value: 'junior',
                                child: Text('junior '),
                              ),
                              DropdownMenuItem(
                                value: 'midLevel',
                                child: Text('midLevel '),
                              ),
                              DropdownMenuItem(
                                value: 'senior',
                                child: Text('senior '),
                              ),
                            ],
                            onChanged: (value) {
                              levelController.text = value.toString();
                            },
                          ),
                        ),
                      ),
                    ),
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
                  height: 15,
                ),

                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Address...',
                    labelStyle: const TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),
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
                  height: 15,
                ),

                TextFormField (
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
                  conditionBuilder: (BuildContext context) => state is! RegisterLoadingState,
                  widgetBuilder: (BuildContext context) => Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if(fromKey.currentState!.validate()){
                         cubit.userRegister(
                            username: nameController.text,
                            phone: countryCode + phoneController.text,
                            password: passwordController.text,
                            experienceYears: int.parse(experienceYears.text),
                            address: addressController.text,
                            level: levelController.text,
                         );
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
                            'Sign up',
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