import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';

import 'widget/user_prevoius_booking.dart';

class PreviouseConsultationsScreen extends StatefulWidget {
  final String title;
  const PreviouseConsultationsScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<PreviouseConsultationsScreen> createState() =>
      _PreviouseConsultationsScreenState();
}

class _PreviouseConsultationsScreenState
    extends State<PreviouseConsultationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: widget.title, context: context),
      body: const UserPrevoiseConsultationsBody(),
    );
  }
}
