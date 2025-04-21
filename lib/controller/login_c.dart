import 'package:app_shoe/view/Home/home.dart';
import 'package:app_shoe/view/Login/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginC extends GetxController {
  final TextEditingController profilec = TextEditingController();
  final TextEditingController passwordc = TextEditingController();
  final RxBool isPasswordHidden = true.obs;
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    String username = profilec.text;
    String password = passwordc.text;
    print('Logging in with username: $username Sand password: $password');
    Get.to(Home());
  }

  void toregister() {
    Get.to(
      () => Register(),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 300),
    );
  }
}
