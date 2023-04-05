import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/partner/widget/body.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: translateString("Credits and partners", "الاعتمادات", ""),
          context: context),
      body: const PartnerBody(),
    );
  }
}
