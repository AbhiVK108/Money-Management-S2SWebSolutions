import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
 final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    // Add login logic
    print("Logging in with email: ${emailController.text}");
  }

  void signup() {
    // Add signup navigation or logic
    print("Navigating to Signup");
  }
}
