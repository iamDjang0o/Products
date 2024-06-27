import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pruduct_app/utils/route/routes.dart';
import 'package:pruduct_app/utils/storage/keys.dart';

class SignInController extends GetxController {
  static const String defaultUsername = 'admin';
  static const String defaultPassword = '12345678';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _box = GetStorage();

  // Function to validate the credentials
  bool validateCredentials(String username, String password) {
    return username == defaultUsername && password == defaultPassword;
  }

  // Sign-in function to validate credentials and navigate to the home page
  void signin(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields',
          colorText: Colors.white, backgroundColor: Colors.red.shade400);
      return;
    }
    if (password.length < 8) {
      Get.snackbar('Error', 'Password must contain at least 8 characters',
          colorText: Colors.white, backgroundColor: Colors.red.shade400);
      return;
    }
    if (validateCredentials(username, password)) {
      String token = "user_token_${DateTime.now().microsecondsSinceEpoch}";
      _box.write(StorageKeys.tokenKey, token); // Store the token in GetStorage

      if (kDebugMode) {
        print('Valid credentials');
      }
      Get.offAllNamed(Routes.home); // Navigate to home screen
    } else {
      Get.snackbar('Error', 'Invalid username or password',
          colorText: Colors.white, backgroundColor: Colors.red.shade400);
    }
  }
}
