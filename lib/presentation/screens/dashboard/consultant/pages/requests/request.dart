import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/requests/widget/body.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';

class RequestScreen extends StatefulWidget {
  final String title;
  const RequestScreen({super.key, required this.title});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: widget.title, context: context),
      body: RefreshIndicator(
          onRefresh: () => GetIt.I<HomeCubit>().getAllRequest(),
          child: const AllRequestBody()),
    );
  }
}
