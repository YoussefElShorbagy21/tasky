import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import '../../shared/resources/asset_manager.dart';
import '../Signup/signup_view.dart';
import 'widget/login_from_filed_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(ImageAssets.startImage),
            LoginFromFiled(),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Didn’t have any account? ',
                    style: TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                  )),
                  TextSpan(
                    text: 'Sign Up here',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView()));
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
            )
          ],
        ),
      ),
    );
  }
}


