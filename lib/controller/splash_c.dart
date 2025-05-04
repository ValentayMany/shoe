import 'package:app_shoe/view/Login/login.dart';
import 'package:app_shoe/view/onBoarding/onboard.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashC extends GetxController {
  final isLoggedIn = false.obs;
  Future<void> loadView() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {
      Get.to(Login());
    } else {
      Get.off(Onboard());
    }
  }
}
