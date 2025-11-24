import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:clipcraft/features/auth/views/email.view.dart';
import 'package:clipcraft/features/auth/views/otp.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.put(AuthController());

    return Scaffold(
      body: PageView(controller: auth.loginPageController, physics: const NeverScrollableScrollPhysics(), children: [const EmailView(), OTPView()]),
    );
  }
}
