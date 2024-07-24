import 'package:flutter/material.dart';
import 'package:tasky/shared/resources/asset_manager.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Login/login_screen.dart';

class StartScreenView extends StatelessWidget {
  const StartScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(ImageAssets.startImage),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Task Management &\nTo-Do List',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF24252C),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'This productive tool is designed to help\nyou better manage your task \nproject-wise conveniently!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6E6A7C),
              fontSize: 14,
              fontWeight: FontWeight.w400,

            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: (){
              CacheHelper.saveData(key:'onBoarding', value: true).then((value){
                if (value == true){
                  navigateFish(context,const LoginScreen());
                }

              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:ColorManager.primary,
              maximumSize: const Size(331, 49),
              minimumSize: const Size(331, 49),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Let’s Start',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(ImageAssets.iconArrow, width: 24, height: 24,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
