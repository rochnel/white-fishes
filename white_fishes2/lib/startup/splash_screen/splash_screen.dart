import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../src/view/product_page.dart';
import '../onboarding_screen/onboarding_screen.dart';




class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;
  late Timer timer;



  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 8 ),);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animationController.forward();
    Timer(const Duration(seconds: 8 ), navigationPage);
  }


  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * (1 / 812.0);
    var width = MediaQuery.of(context).size.width * (1 / 375.0)  ;
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: height * 812,
          width: width * 375,
          child: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  )
              ),
              Center(
                child: SizedBox(
                  height: height * 197,
                  width: width * 197,
                  child: Center(
                    child: SizedBox(
                        height: height * 197,
                        width: width * 197,
                        child: Image.asset(
                          "assets/images/logo2.png",
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }



  void navigationPage() async {
   Get.off(OnboardingScreen());
  }
}