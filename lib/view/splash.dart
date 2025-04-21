import 'package:app_shoe/controller/splash_c.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashC = Get.put(SplashC());
  @override
  void initState() {
    super.initState();
    splashC.loadView();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('images/TUV.png', width: size.width * 0.3),
      ),
    );
  }
}
