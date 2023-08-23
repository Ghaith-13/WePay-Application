import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepay/Intro_Slider_Screen.dart';
import 'package:page_transition/page_transition.dart';

import 'Pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/Logo.png',
      ),
      nextScreen: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            var token = snapshot.data?.getString('token');
            if (token != null) {
              return Pages();
            } else {
              return OnBoardingPage();
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      backgroundColor: Colors.white,
      splashIconSize: 250,
      duration: 500,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
   // home: FutureBuilder<SharedPreferences>(
              //   future: SharedPreferences.getInstance(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<SharedPreferences> snapshot) {
              //     if (snapshot.hasData) {
              //       var token = snapshot.data?.getString('token');
              //       if (token != null) {
              //         return Pages();
              //       } else {
              //         return SplashScreen();
              //       }
              //     } else {
              //       return CircularProgressIndicator();
              //     }
              //   },
              // ),