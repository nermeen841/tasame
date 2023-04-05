import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/auth/forgetpassword/widget/body.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(
        title: "",
        context: context,
      ),
      body: const ForgetPasswordBody(),
    );
  }
}
