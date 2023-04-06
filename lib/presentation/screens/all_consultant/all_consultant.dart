// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import '../../widget/consult-list.dart';
import '../../widget/search_result.dart';
import '../contactus/cubit/setting_cubit.dart';
import '../home/cubit/home_cubit.dart';
import '../home/widget/filter-search.dart';

class AllConsultantScreen extends StatefulWidget {
  const AllConsultantScreen({Key? key}) : super(key: key);

  @override
  State<AllConsultantScreen> createState() => _AllConsultantScreenState();
}

class _AllConsultantScreenState extends State<AllConsultantScreen> {
  @override
  void initState() {
    isSearching = false;
    GetIt.I<HomeCubit>().getAllConsultant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<HomeCubit>().getAllConsultant(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        bloc: GetIt.I<HomeCubit>(),
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: BlocConsumer<SettingCubit, SettingState>(
              bloc: GetIt.I<SettingCubit>(),
              builder: (context, state) => FloatingActionButton(
                heroTag: "hero4",
                onPressed: () async {
                  if (Platform.isAndroid) {
                    await launch(
                        "https://wa.me/${GetIt.I<SettingCubit>().settingModel!.data!.whatsappLink!}/?text=${Uri.parse("")}"); // new line
                  } else {
                    await launch(
                        "https://api.whatsapp.com/send?phone=${GetIt.I<SettingCubit>().settingModel!.data!.whatsappLink!}=${Uri.parse("")}"); // new line
                  }
                },
                backgroundColor: Colors.green,
                child: Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: screenWidth(context) * 0.07,
                ),
              ),
              listener: (context, state) {},
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context) * 0.04,
                vertical: screenHeight(context) * 0.02,
              ),
              child: Column(
                children: [
                  const VerticalSpace(value: 2),
                  const FilterSearchHome(),
                  const VerticalSpace(value: 2),
                  (isSearching)
                      ? const SearchResultData()
                      : const ConultantList(),
                  const VerticalSpace(value: 3),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
