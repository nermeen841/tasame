import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/auth/forgetpassword/code/body.dart';

class CodeScreen extends StatefulWidget {
  final bool fromLogin;
  const CodeScreen({Key? key, required this.fromLogin}) : super(key: key);

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "", context: context),
      body: CodeBody(
        fromLogin: widget.fromLogin,
      ),
    );
  }
}
