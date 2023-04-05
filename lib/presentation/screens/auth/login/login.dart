import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';

import 'widget/body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(title: "", context: context),
      body: const LoginBody(),
    );
  }
}
