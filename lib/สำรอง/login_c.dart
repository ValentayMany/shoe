import 'package:app_shoe/Services/apiconstants.dart';
import 'package:app_shoe/Services/apiservice.dart';
import 'package:app_shoe/view/Home/layout.dart';
import 'package:app_shoe/view/Login/register.dart';
import 'package:app_shoe/view/Login/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginC extends GetxController {
  // Controllers
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observables
  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  // Services
  final ApiService _apiService = ApiService();

  // Saved identifier
  final RxString savedIdentifier = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedIdentifier(); // โหลดค่าทันทีเมื่อ controller ถูกสร้าง
  }

  Future<void> loadSavedIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    savedIdentifier.value = prefs.getString('identifier') ?? '';
  }

  @override
  void onClose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (!_validateInputs()) return;

    isLoading.value = true;
    EasyLoading.show(status: 'Loading...');

    try {
      final response = await _apiService.post(
        ApiConstants.loginEndpoint,
        data: {
          'identifier': emailPhoneController.text.trim(),
          'Password': passwordController.text,
        },
      );

      isLoading.value = false;
      EasyLoading.dismiss();

      if (response.success) {
        final token = response.data['token'];
        // บันทึก token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('identifier', emailPhoneController.text.trim());
        // print('Token received: $token');

        // ตรวจสอบอีกครั้งว่าบันทึกสำเร็จ
        // final storedToken = prefs.getString('token');
        // print('Stored token after login: $storedToken');
        _navigateToHome();
      } else {
        _showErrorMessage(response.message ?? 'Login failed');
      }
    } catch (e) {
      isLoading.value = false;
      EasyLoading.dismiss();
      _showErrorMessage('Connection error. Please try again.');
      print('Login error: $e');
    }
  }

  bool _validateInputs() {
    if (emailPhoneController.text.isEmpty) {
      _showErrorMessage('Please enter your email or phone');
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showErrorMessage('Please enter your password');
      return false;
    }

    return true;
  }

  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void _navigateToHome() {
    Get.offAll(() => Layout());
  }

  void navigateToRegister() {
    Get.to(
      () => Register(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  void navigateToWelcome() {
    Get.to(
      () => Welcome(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }
}
