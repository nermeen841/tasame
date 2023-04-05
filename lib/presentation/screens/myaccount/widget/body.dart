import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/myaccount/tabs_view/tutor_profile.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/space_widget.dart';
import '../tabs_view/profile_form.dart';
import '../tabs_view/subscription.dart';
import 'package:easy_localization/easy_localization.dart';

class MyAccountBody extends StatefulWidget {
  const MyAccountBody({Key? key}) : super(key: key);

  @override
  State<MyAccountBody> createState() => _MyAccountBodyState();
}

class _MyAccountBodyState extends State<MyAccountBody> {
  int currentIndex = 0;
  List<String> txt = [
    LocaleKeys.PROFILE.tr(),
    // LocaleKeys.SUBERSIPTION.tr(),
    // LocaleKeys.ADDRESS.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight(context) * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(screenWidth(context) * 0.01),
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
                  LocaleKeys.PROFILE_MESSAGE.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const VerticalSpace(value: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  txt.length, (index) => buildOptions(index: index)),
            ),
            (currentIndex != 0)
                ? const SubscriptionViwe()
                : (prefs.getString("user_type") == "consultant")
                    ? const TutorProfileForm()
                    : const ProfileForm(),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildOptions({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Container(
          width: screenWidth(context) * 0.35,
          height: screenHeight(context) * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth(context) * 0.02),
              topRight: Radius.circular(screenWidth(context) * 0.02),
            ),
            color: (currentIndex == index) ? Colors.white : Colors.transparent,
          ),
          child: Center(
            child: Text(
              txt[index],
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
