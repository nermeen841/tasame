// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import 'package:zat/presentation/screens/home/widget/slider.dart';
import 'package:zat/presentation/widget/search_result.dart';
import '../../../core/constants/colors.dart';
import '../../../generator/locale_keys.dart';
import '../../widget/consult-list.dart';
import '../contactus/cubit/setting_cubit.dart';
import 'widget/filter-search.dart';
import 'package:easy_localization/easy_localization.dart';

import 'widget/social.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    isSearching = false;
    keyword = "";
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
                heroTag: "hero1",
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
                  const HomeSlider(),
                  const VerticalSpace(value: 3),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context) * 0.03,
                        vertical: screenHeight(context) * 0.02),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(screenWidth(context) * 0.015),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: colorGrey.withOpacity(0.2),
                          offset: const Offset(0, 1),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.HOME_FILTER_MESSAGE.tr(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: headingStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(context) * 0.035,
                          color: colordeepGrey,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpace(value: 2),
                  const FilterSearchHome(),
                  const VerticalSpace(value: 2),
                  (isSearching)
                      ? const SearchResultData()
                      : const ConultantList(),
                  const VerticalSpace(value: 3),
                  const SocialIconsView(),
                  const VerticalSpace(value: 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
