import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../shared/resources/asset_manager.dart';
import '../../shared/resources/color_manager.dart';
import '../Login/login_screen.dart';
import 'widget/signup_form_filed.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
         children: [
           Image.asset(ImageAssets.startImage),
           SignupFormFiled(),
           Text.rich(
             TextSpan(
               children: [
                 const TextSpan(
                     text: 'Already have any account? ',
                     style: TextStyle(
                       color: Color(0xFF7F7F7F),
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                     )),
                 TextSpan(
                   text: 'Sign in',
                   recognizer: TapGestureRecognizer()
                     ..onTap = () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                     },
                   style: TextStyle(
                     color: ColorManager.primary,
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     decoration: TextDecoration.underline,
                   ),
                 ),
               ],
             ),
             textAlign: TextAlign.center,
           ),
         ],
        ),
      )
    );
  }
}
