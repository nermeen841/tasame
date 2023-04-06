// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/contactus/contactus.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import 'package:zat/presentation/screens/info/info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/partner/partner.dart';
import '../../widget/country_alert.dart';
import '../blogs screens/cubit/blogs_cubit.dart';
import '../blogs screens/pages/write_your_blog.dart';
import '../contactus/cubit/setting_cubit.dart';
import '../qustionare/cubit/quastionaire_cubit.dart';

class MenueScreen extends StatefulWidget {
  const MenueScreen({Key? key}) : super(key: key);

  @override
  State<MenueScreen> createState() => _MenueScreenState();
}

class _MenueScreenState extends State<MenueScreen> {
  String? title;
  String? content;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocConsumer<SettingCubit, SettingState>(
        bloc: GetIt.I<SettingCubit>(),
        builder: (context, state) => FloatingActionButton(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<SettingCubit, SettingState>(
              listener: (context, state) {},
              bloc: GetIt.I<SettingCubit>(),
              builder: (context, state) {
                if (GetIt.I<SettingCubit>().customPagesModel != null) {
                  for (var element
                      in GetIt.I<SettingCubit>().customPagesModel!.data!) {
                    if (element.title == "من نحن" ||
                        element.title == "About Thaat") {
                      title = element.title;
                      content = element.body!;
                      image = element.image!;
                    }
                  }
                }
                return (GetIt.I<SettingCubit>().customPagesModel != null)
                    ? ListTile(
                        textColor: Colors.black,
                        onTap: () => MagicRouter.navigateTo(
                          InfoScreen(
                            image: image,
                            title:
                                translateString("About Tasame", "عن تسامي", ""),
                            content: content!,
                          ),
                        ),
                        title: Text(
                          translateString("About Tasame", "عن تسامي", ""),
                          style: headingStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.04,
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
            ListTile(
              textColor: Colors.black,
              onTap: () {
                GetIt.I<ProfileCubit>()
                    .getSpecialicity()
                    .then((value) => showSpecialicityAlert(context));
              },
              title: Text(
                translateString("Consultations", "الاستشارات", ""),
                style: headingStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
            ),
            (prefs.getString("user_type") == "user")
                ? BlocConsumer<QuastionaireCubit, QuastionaireState>(
                    listener: (context, state) {},
                    bloc: GetIt.I<QuastionaireCubit>(),
                    builder: (context, state) {
                      return ListTile(
                        textColor: Colors.black,
                        // leading: Icon(
                        //   CupertinoIcons.list_bullet_below_rectangle,
                        //   color: colordeepGrey,
                        //   size: screenWidth(context) * 0.08,
                        // ),
                        onTap: () async {
                          await GetIt.I<QuastionaireCubit>()
                              .getQuastionare()
                              .then((value) {
                            MagicRouter.navigateAndPopAll(const LayoutScreen(
                              index: 3,
                            ));
                          });
                        },
                        title: Text(
                          translateString("Scales", "المقاييس", ""),
                          // LocaleKeys.QUASTIONARE.tr(),
                          style: headingStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.04,
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
            BlocConsumer<BlogsCubit, BlogsState>(
              listener: (context, state) {},
              bloc: GetIt.I<BlogsCubit>(),
              builder: (context, state) {
                return ListTile(
                  textColor: Colors.black,
                  // leading: Icon(
                  //   CupertinoIcons.book_fill,
                  //   color: colordeepGrey,
                  //   size: screenWidth(context) * 0.08,
                  // ),
                  onTap: () {
                    GetIt.I<BlogsCubit>().getWrittingdata();
                    MagicRouter.navigateTo(const WriteYourBlogScreen());
                  },
                  title: Text(
                    LocaleKeys.WRITTING.tr(),
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(context) * 0.04,
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<BlogsCubit, BlogsState>(
              listener: (context, state) {},
              bloc: GetIt.I<BlogsCubit>(),
              builder: (context, state) {
                return ListTile(
                  textColor: Colors.black,
                  onTap: () {
                    GetIt.I<BlogsCubit>().getSuccessStories(0);
                  },
                  // leading: Icon(
                  //   CupertinoIcons.video_camera_solid,
                  //   color: colordeepGrey,
                  //   size: screenWidth(context) * 0.08,
                  // ),
                  title: Text(
                    LocaleKeys.SUCCESS_STORY.tr(),
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(context) * 0.04,
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<BlogsCubit, BlogsState>(
              listener: (context, state) {},
              bloc: GetIt.I<BlogsCubit>(),
              builder: (context, state) {
                return ListTile(
                  textColor: Colors.black,
                  onTap: () {
                    GetIt.I<BlogsCubit>().getSuccessStories(1);
                  },
                  // leading: Icon(
                  //   CupertinoIcons.video_camera_solid,
                  //   color: colordeepGrey,
                  //   size: screenWidth(context) * 0.08,
                  // ),
                  title: Text(
                    translateString("Tasame Studio", "استوديو تسامي", ""),
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(context) * 0.04,
                    ),
                  ),
                );
              },
            ),
            // ListTile(
            //   textColor: Colors.black,
            //   onTap: () {
            //     showblogOptions(context);
            //   },
            //   title: Text(
            //     translateString("Blog", "المدونة", ""),
            //     style: headingStyle.copyWith(
            //       fontWeight: FontWeight.bold,
            //       fontSize: screenWidth(context) * 0.04,
            //     ),
            //   ),
            // ),
            ListTile(
              textColor: Colors.black,
              onTap: () async {
                dialog(context);
                await GetIt.I<HomeCubit>().getPartner().then((value) {
                  MagicRouter.pop();
                  MagicRouter.navigateTo(const PartnerScreen());
                });
              },
              title: Text(
                translateString("Credits and partners", "الاعتمادات", ""),
                style: headingStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
            ),

            ListTile(
              textColor: Colors.black,
              onTap: () => MagicRouter.navigateTo(const ContactUsScreen()),
              title: Text(
                LocaleKeys.CONTACT_US.tr(),
                style: headingStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
