import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruduct_app/pages/auth/login/controller/login_controller.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.signInController,
  });

  final SignInController signInController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        maximumSize: MaterialStateProperty.all(Size(Get.width, 60)),
        minimumSize: MaterialStateProperty.all(Size(Get.width, 60)),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: () {
        signInController.signin(
          signInController.usernameController.text,
          signInController.passwordController.text,
        );
      },
      child: const Text('Sign In',
          style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
