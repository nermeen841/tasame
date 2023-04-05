// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:zat/presentation/screens/intro/widget/body.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, body: SplashBody());
  }
}
