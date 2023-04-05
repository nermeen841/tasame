// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/colors.dart';
import '../../contactus/cubit/setting_cubit.dart';

class SocialIconsView extends StatefulWidget {
  const SocialIconsView({Key? key}) : super(key: key);

  @override
  State<SocialIconsView> createState() => _SocialIconsViewState();
}

class _SocialIconsViewState extends State<SocialIconsView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {},
      bloc: GetIt.I<SettingCubit>(),
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async => await launch(
                  GetIt.I<SettingCubit>().settingModel!.data!.facebookLink!),
              child: Icon(
                FontAwesomeIcons.facebook,
                color: colorBetrolly,
              ),
            ),
            InkWell(
              onTap: () async => await launch(
                  GetIt.I<SettingCubit>().settingModel!.data!.twitterLink!),
              child: Icon(
                FontAwesomeIcons.twitter,
                color: colorBetrolly,
              ),
            ),
            InkWell(
              onTap: () async => await launch(
                  GetIt.I<SettingCubit>().settingModel!.data!.instagramLink!),
              child: Icon(
                FontAwesomeIcons.instagram,
                color: colorBetrolly,
              ),
            ),
            InkWell(
              onTap: () async => await launch(
                  GetIt.I<SettingCubit>().settingModel!.data!.snapchatLink!),
              child: Icon(
                FontAwesomeIcons.snapchat,
                color: colorBetrolly,
              ),
            ),
            InkWell(
              onTap: () async => await launch(
                  GetIt.I<SettingCubit>().settingModel!.data!.pinterest!),
              child: Icon(
                FontAwesomeIcons.pinterest,
                color: colorBetrolly,
              ),
            ),
            InkWell(
              onTap: () async => await launch(
                  GetIt.I<SettingCubit>().settingModel!.data!.tiktok!),
              child: Icon(
                FontAwesomeIcons.tiktok,
                color: colorBetrolly,
              ),
            ),
            InkWell(
              onTap: () async {
                if (Platform.isAndroid) {
                  await launch(
                      "https://wa.me/${GetIt.I<SettingCubit>().settingModel!.data!.whatsappLink!}/?text=${Uri.parse("")}"); // new line
                } else {
                  await launch(
                      "https://api.whatsapp.com/send?phone=${GetIt.I<SettingCubit>().settingModel!.data!.whatsappLink!}=${Uri.parse("")}"); // new line
                }
              },
              child: Icon(
                FontAwesomeIcons.whatsapp,
                color: colorBetrolly,
              ),
            ),
          ],
        );
      },
    );
  }
}
