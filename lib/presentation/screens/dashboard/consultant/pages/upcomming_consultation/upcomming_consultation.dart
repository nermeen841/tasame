import 'package:flutter/material.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';

import '../../../../../../core/constants/constants.dart';
import 'widget/body.dart';

class UpcommingConsultationTutor extends StatefulWidget {
  final String title;
  final bool fromAuth;
  const UpcommingConsultationTutor(
      {super.key, required this.title, required this.fromAuth});

  @override
  State<UpcommingConsultationTutor> createState() =>
      _UpcommingConsultationTutorState();
}

class _UpcommingConsultationTutorState
    extends State<UpcommingConsultationTutor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: widget.title,
          context: context,
          press: (widget.fromAuth == true)
              ? () => MagicRouter.navigateAndPopAll(const LayoutScreen())
              : () => MagicRouter.pop()),
      body: const UpcommingConsultationTutorBody(),
    );
  }
}
