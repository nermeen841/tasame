// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'orders_body.dart';

class QuastionareOrdersScreen extends StatefulWidget {
  const QuastionareOrdersScreen({Key? key}) : super(key: key);

  @override
  State<QuastionareOrdersScreen> createState() =>
      _QuastionareOrdersScreenState();
}

class _QuastionareOrdersScreenState extends State<QuastionareOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: translateString("Record metrics", "سجل المقاييس", ""),
          context: context),
      body: const QuastionareOrdersBody(),
    );
  }
}
