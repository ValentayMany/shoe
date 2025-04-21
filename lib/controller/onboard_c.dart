import 'package:app_shoe/view/Login/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardC extends GetxController {
  final List<Map<String, dynamic>> onboardData = [
    {
      'image': 'images/onboard1.png',
      'title': 'View product 360 degrees',
      'description':
          'You can see the product with all angles, true and convenient',
    },
    {
      'image': 'images/onboard2.png',
      'title': 'View product 360 degrees',
      'description': 'Connect with friends and family easily.',
    },
    {
      'image': 'images/onboard3.png',
      'title': 'Get Started Now',
      'description': 'Join us and explore the world of possibilities.',
    },
  ];
  final PageController pageonbord = PageController();
  final currentboard = 0.obs;
  void onPageChanged(int index) {
    currentboard.value = index;
  }

  void onNextPage() {
    if (currentboard.value < onboardData.length - 1) {
      pageonbord.nextPage(
        duration: Duration(milliseconds: 300), // ระยะเวลาเปลี่ยนหน้า
        curve: Curves.fastOutSlowIn, // ลักษณะการเคลื่อนไหว
      );
    } else {
      Get.to(Welcome());
    }
  }
}
