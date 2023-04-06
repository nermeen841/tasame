// ignore_for_file: deprecated_member_use
import 'package:api_request/api_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/generator/localization_constant.dart';
import 'package:zat/presentation/screens/contactus/cubit/setting_cubit.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/appointment/appointment.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/offers/offers.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/myaccount/myaccount.dart';
import '../../../core/constants/constants.dart';
import '../../../core/router/router.dart';
import '../all_consultant/all_consultant.dart';
import '../dashboard/user/upcommingconsultation/upcomming_consultation.dart';
import '../home/body.dart';
import '../menue/menu.dart';
import '../qustionare/cubit/quastionaire_cubit.dart';
import '../qustionare/qustionare.dart';
import '../splash/splash.dart';
import 'appbar.dart';
import 'package:easy_localization/easy_localization.dart';

class LayoutScreen extends StatefulWidget {
  final int? index;
  const LayoutScreen({Key? key, this.index}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  PersistentTabController? controller;
  int currentIndex = 0;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return (prefs.getString("user_type") == "user")
        ? [
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.computer_outlined),
              title: (translateString("My booking", "حجوزاتي", "")),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.alarm,
              ),
              title: (translateString("Book", "حجز", "")),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.line_horizontal_3_decrease_circle,
                color: Colors.white,
              ),
              title: (LocaleKeys.MENUE.tr()),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.list_bullet_below_rectangle,
              ),
              title: translateString("Scales", "المقاييس", ""),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(CupertinoIcons.home),
              title: (LocaleKeys.HOME.tr()),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
          ]
        : [
            PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.calendar,
              ),
              title: translateString("Appointment", "المواعيد", ""),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.money_dollar_circle,
              ),
              title: translateString("Packages", "الباقات", ""),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.line_horizontal_3_decrease_circle,
                color: Colors.white,
              ),
              title: (LocaleKeys.MENUE.tr()),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(CupertinoIcons.person),
              title: (LocaleKeys.MY_PROFILE.tr()),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(CupertinoIcons.home),
              title: (LocaleKeys.HOME.tr()),
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
          ];
  }

  List<Widget> _buildScreens() {
    return (prefs.getString("user_type") == "user")
        ? [
            UpcommingConsultationsScreen(
              fromAuth: false,
              title: translateString("Upcomming Consultations",
                  "الاستشارات القادمة", "Yaklaşan İstişareler"),
              fromHome: true,
            ),
            const AllConsultantScreen(),
            const MenueScreen(),
            const QuastionareScreen(
              fromHome: true,
            ),
            const HomeScreen(),
          ]
        : const [
            ManageTutorAppointmentScreen(
              fromHome: true,
            ),
            ManageOffersScreen(
              fromHome: true,
            ),
            MenueScreen(),
            MyProfileScreen(
              fromHome: true,
            ),
            HomeScreen(),
          ];
  }

  @override
  void initState() {
    controller = PersistentTabController(initialIndex: widget.index ?? 0);
    GetIt.I<ProfileCubit>().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: layoutAppbar(
        context,
        (value) {
          if (value == 1) {
            setState(() {
              ApiRequestOptions.instance
                  ?.config(defaultHeaders: {"lang": "en"});
              ApiRequestOptions.refreshConfig();
              setLocale("en");
              context.locale = const Locale('en', '');
              prefs.setString("lang", "en");
              prefs.setString("language", "English");
            });

            MagicRouter.navigateAndPopAll(const SplashScreen());
          } else if (value == 3) {
            setState(() {
              ApiRequestOptions.instance
                  ?.config(defaultHeaders: {"lang": "tr"});
              ApiRequestOptions.refreshConfig();
              setLocale("tr");
              context.locale = const Locale('tr', '');
              prefs.setString("lang", "tr");
              prefs.setString("language", "Türkçe");
            });

            MagicRouter.navigateAndPopAll(const SplashScreen());
          } else if (value == 2) {
            setState(() {
              ApiRequestOptions.instance
                  ?.config(defaultHeaders: {"lang": "ar"});
              ApiRequestOptions.refreshConfig();
              setLocale("ar");
              context.locale = const Locale('ar', '');
              prefs.setString("lang", "ar");

              prefs.setString("language", "العربية");
            });

            MagicRouter.navigateAndPopAll(const SplashScreen());
          }
        },
      ),
      body: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: (value) {
          setState(() {
            currentIndex = value;
          });
          if (prefs.getString("user_type") == "user") {
            if (value == 3) {
              GetIt.I<QuastionaireCubit>().getQuastionare();
            } else if (value == 2) {
              GetIt.I<SettingCubit>().getCustomPage();
              GetIt.I<SettingCubit>().getSettingData();
            } else if (value == 0) {
              GetIt.I<ProfileCubit>().getUserProfile();
            }
          } else {
            if (value == 2) {
              GetIt.I<SettingCubit>().getCustomPage();
              GetIt.I<SettingCubit>().getSettingData();
            } else if (value == 1 || value == 3 || value == 0) {
              GetIt.I<ProfileCubit>().getUserProfile();
            }
          }
        },
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        popAllScreensOnTapAnyTabs: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: false,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
