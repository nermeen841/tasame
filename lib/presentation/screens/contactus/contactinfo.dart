// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/constants.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/space_widget.dart';
import 'cubit/setting_cubit.dart';

class ContactusInfoItem extends StatelessWidget {
  const ContactusInfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {},
      bloc: GetIt.I<SettingCubit>(),
      builder: (context, state) {
        return (GetIt.I<SettingCubit>().settingModel != null)
            ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async => await launch(
                            'tel: ${GetIt.I<SettingCubit>().settingModel!.data!.mobile1!}'),
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.phone_fill,
                              color: colordeepGrey,
                            ),
                            const VerticalSpace(value: 1),
                            Text(
                              GetIt.I<SettingCubit>()
                                  .settingModel!
                                  .data!
                                  .mobile1!,
                              style: headingStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth(context) * 0.03,
                                color: colordeepGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: GetIt.I<SettingCubit>()
                                .settingModel!
                                .data!
                                .email1!,
                            queryParameters: {'subject': '', 'body': ''},
                          );
                          String url = params.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print('Could not launch $url');
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.envelope_fill,
                              color: colordeepGrey,
                            ),
                            const VerticalSpace(value: 1),
                            Text(
                              GetIt.I<SettingCubit>()
                                  .settingModel!
                                  .data!
                                  .email1!,
                              style: headingStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth(context) * 0.03,
                                color: colordeepGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async => await launch(
                            'tel: ${GetIt.I<SettingCubit>().settingModel!.data!.mobile2!}'),
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.phone_fill,
                              color: colordeepGrey,
                            ),
                            const VerticalSpace(value: 1),
                            Text(
                              GetIt.I<SettingCubit>()
                                  .settingModel!
                                  .data!
                                  .mobile2!,
                              style: headingStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth(context) * 0.03,
                                color: colordeepGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpace(value: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: GetIt.I<SettingCubit>()
                                .settingModel!
                                .data!
                                .email2!,
                            queryParameters: {'subject': '', 'body': ''},
                          );
                          String url = params.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print('Could not launch $url');
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.envelope_fill,
                              color: colordeepGrey,
                            ),
                            const VerticalSpace(value: 1),
                            Text(
                              GetIt.I<SettingCubit>()
                                  .settingModel!
                                  .data!
                                  .email2!,
                              style: headingStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth(context) * 0.03,
                                color: colordeepGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
