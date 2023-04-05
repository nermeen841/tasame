import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/orders/widget/body.dart';

class OrdersScreen extends StatefulWidget {
  final String title;
  const OrdersScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: widget.title, context: context),
      body: const OrdersBody(),
    );
  }
}
