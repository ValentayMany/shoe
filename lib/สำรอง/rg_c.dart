import 'package:app_shoe/view/Login/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterC extends GetxController {
  final TextEditingController phonec = TextEditingController();
  final TextEditingController emailc = TextEditingController();
  final TextEditingController firstnamec = TextEditingController();
  final TextEditingController lastnamec = TextEditingController();
  final TextEditingController genderc = TextEditingController(text: "Male");
  final TextEditingController birthdayc = TextEditingController();
  final TextEditingController passwordc = TextEditingController();
  final TextEditingController confirmPasswordc = TextEditingController();
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  final RxString confirmPasswordError = ''.obs;
  void validatePasswordMatch() {
    if (confirmPasswordc.text != passwordc.text) {
      confirmPasswordError.value = "Passwords do not match";
    } else {
      confirmPasswordError.value = "";
    }
  }

  final RxString phoneError = ''.obs;
  void validatePhone() {
    final phone = phonec.text;
    if (phone.isEmpty) {
      phoneError.value = 'กรุณากรอกเบอร์โทรศัพท์';
    } else if (phone.length < 8) {
      phoneError.value = 'เบอร์โทรศัพท์ต้องมีอย่างน้อย 8 หลัก';
    } else {
      phoneError.value = '';
    }
  }

  final RxString emailError = ''.obs;
  void validateEmail() {
    final email = emailc.text;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email.isEmpty) {
      emailError.value = 'กรุณากรอกอีเมล';
    } else if (!emailRegex.hasMatch(email)) {
      emailError.value = 'รูปแบบอีเมลไม่ถูกต้อง';
    } else {
      emailError.value = '';
    }
  }

  void register() {
    String phone = phonec.text;
    String email = emailc.text;
    String firstname = firstnamec.text;
    String lastname = lastnamec.text;
    String gender = genderc.text;
    String birthday = birthdayc.text;
    String password = passwordc.text;

    if (phone.isEmpty ||
        email.isEmpty ||
        firstname.isEmpty ||
        lastname.isEmpty ||
        gender.isEmpty ||
        birthday.isEmpty ||
        password.isEmpty) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'กรุณากรอกข้อมูลให้ครบทุกช่อง',
        icon: Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    if (confirmPasswordError.value.isNotEmpty ||
        phoneError.value.isNotEmpty ||
        emailError.value.isNotEmpty) {
      return;
    }

    // แสดง Dialog ยืนยันข้อมูล
    Get.defaultDialog(
      title: "ตรวจสอบข้อมูล",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("โทรศัพท์: $phone"),
          Text("อีเมล: $email"),
          Text("ชื่อ: $firstname $lastname"),
          Text("เพศ: $gender"),
          Text("วันเกิด: $birthday"),
          Text("รหัสผ่าน: $password"),
        ],
      ),
      textConfirm: "ตกลง",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.to(Welcome());
      },
    );
  }

  void towelcome() {
    Get.to(
      () => Welcome(),
      transition: Transition.leftToRight,
      duration: Duration(milliseconds: 300),
    );
  }

  // Registration variables
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  // Lists for dropdown items
  final List<String> days = List.generate(
    31,
    (index) => (index + 1).toString().padLeft(2, '0'),
  );
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<String> years = List.generate(
    100,
    (index) => (DateTime.now().year - index).toString(),
  );
}
