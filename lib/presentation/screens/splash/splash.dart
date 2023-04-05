import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/utiles/size_config.dart';
import 'package:zat/presentation/screens/intro/intro.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget screen = const OnBoardingScreen();

  getScreen() {
    if (prefs.getBool("login") == true) {
      setState(() {
        screen = const LayoutScreen();
      });
    } else {
      setState(() {
        screen = const OnBoardingScreen();
      });
    }
  }

  @override
  void initState() {
    getScreen();
    Timer(const Duration(seconds: 2),
        () => MagicRouter.navigateAndPopAll(screen));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "asset/icons/app_logo.png",
          width: screenWidth(context) * 0.6,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
