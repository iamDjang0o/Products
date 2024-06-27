import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pruduct_app/components/images.dart';
import 'package:pruduct_app/components/widgets/textfield.dart';
import 'package:pruduct_app/pages/auth/login/controller/login_controller.dart';

class SignInPage extends StatelessWidget {
  final SignInController signInController = Get.put(SignInController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SizedBox(
                // reduce size when keyboard is open
                height:
                    MediaQuery.viewInsetsOf(context).bottom == 0 ? 280 : 200,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(AssetPaths.welcome)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(150),
                MyTextfield(
                  hint: 'Email',
                  controller: signInController.usernameController,
                  obscure: false,
                  onchanged: (value) {},
                ),
                const Gap(10),
                MyTextfield(
                  hint: 'Password',
                  controller: signInController.passwordController,
                  obscure: true,
                  onchanged: (value) {},
                ),
                const Gap(15),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
