import 'package:app_shoe/view/Login/login.dart';
import 'package:app_shoe/view/Login/register.dart';
import 'package:app_shoe/view/onBoarding/onboard.dart';
import 'package:get/get.dart';

class SplashC extends GetxController {
  final isLoggedIn =
      false
          .obs; //false.obs; // Change this to true or false based on your login logic
  Future<void> loadView() async {
    await Future.delayed(const Duration(seconds: 2));
    if (isLoggedIn.value) {
      Get.to(Login());
    } else {
      Get.to(Onboard());
    }
  }
}
