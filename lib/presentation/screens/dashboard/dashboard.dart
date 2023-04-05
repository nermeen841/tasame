import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/dashboard/user/body.dart';
import 'consultant/widget/body.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: translateString("Dasboard", "لوحة التحكم", "Gösterge Paneli"),
          context: context),
      body: (prefs.getString("user_type") == "user")
          ? const UserDashBoardScreen()
          : const DashboardBody(),
    );
  }
}
