// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:zat/presentation/screens/info/body.dart';
import '../../../core/constants/constants.dart';

class InfoScreen extends StatefulWidget {
  final String title;
  final String content;
  final String? image;
  const InfoScreen(
      {Key? key, required this.title, required this.content, this.image})
      : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: "",
        context: context,
      ),
      body: InfoBody(
        title: widget.title,
        content: widget.content,
        image: widget.image!,
      ),
    );
  }
}
