// ignore_for_file: deprecated_member_use

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/auth/bloc/Auth_cubit/auth_cubit.dart';
import 'package:zat/presentation/screens/dashboard/dashboard.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/space_widget.dart';
import '../../../generator/locale_keys.dart';
import '../myaccount/myaccount.dart';
import 'package:easy_localization/easy_localization.dart';

AppBar layoutAppbar(context, Function(int)? onSelected) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0.0,
    leading: Badge(
      badgeStyle: const BadgeStyle(badgeColor: Color(0xffFF0921)),
      badgeAnimation: const BadgeAnimation.fade(
        animationDuration: Duration(
          seconds: 2,
        ),
      ),
      badgeContent: Text(
        "0",
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth(context) * 0.03,
        ),
      ),
      position: BadgePosition.topStart(
        start: screenWidth(context) * 0.02,
        top: -(screenHeight(context) * 0.002),
      ),
      child: IconButton(
        icon: Icon(
          Icons.notifications,
          color: kMainColor,
          size: screenWidth(context) * 0.07,
        ),
        padding: EdgeInsets.zero,
        focusColor: Colors.white,
        onPressed: () {},
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          MagicRouter.navigateTo(const DashboardScreen());
        },
        child: Text(
          translateString("Dashboard", "لوحة التحكم", "Gösterge Paneli"),
          style: headingStyle.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const HorizontalSpace(value: 2),
      PopupMenuButton(
        onSelected: onSelected,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              prefs.getString("language") ?? "English",
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black87),
          ],
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "English",
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "اللغة العربية",
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // PopupMenuItem(
          //   value: 3,
          //   child: Text(
          //     "Türkçe",
          //     style: headingStyle.copyWith(
          //       color: Colors.black,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
        ],
      ),
      const HorizontalSpace(value: 2),
      PopupMenuButton(
        onSelected: (value) {
          if (value == 1) {
            dialog(context);
            GetIt.I<ProfileCubit>().getUserProfile().then((value) {
              MagicRouter.pop();
              MagicRouter.navigateTo(const MyProfileScreen());
            });
          } else {
            GetIt.I<AuthCubit>().postLogOut();
          }
        },
        child: (prefs.getString("user_type") == "user")
            ? CircleAvatar(
                backgroundColor: colorGrey,
                child: const Center(
                  child: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                ),
              )
            : BlocConsumer<ProfileCubit, ProfileState>(
                bloc: GetIt.I<ProfileCubit>(),
                builder: (context, state) {
                  if (GetIt.I<ProfileCubit>().tutorProfileModel != null) {
                    return (GetIt.I<ProfileCubit>()
                                    .tutorProfileModel!
                                    .data!
                                    .image !=
                                null &&
                            GetIt.I<ProfileCubit>()
                                    .tutorProfileModel!
                                    .data!
                                    .image !=
                                "")
                        ? CircleAvatar(
                            backgroundColor: colorGrey,
                            backgroundImage: NetworkImage(
                                GetIt.I<ProfileCubit>()
                                    .tutorProfileModel!
                                    .data!
                                    .image!),
                          )
                        : CircleAvatar(
                            backgroundColor: colorGrey,
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.person,
                                color: Colors.white,
                              ),
                            ),
                          );
                  } else {
                    return const SizedBox();
                  }
                },
                listener: (context, state) {},
              ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              LocaleKeys.MY_PROFILE.tr(),
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              LocaleKeys.LOG_OUT.tr(),
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      const HorizontalSpace(value: 1.5),
    ],
  );
}