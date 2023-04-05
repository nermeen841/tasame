import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/blogs%20screens/pages/write_your_blog.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../core/constants/constants.dart';
import '../screens/blogs screens/cubit/blogs_cubit.dart';
import '../screens/tutor_offers/tutor_offers.dart';

void showCountryDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        scrollable: false,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(screenWidth(context) * 0.03),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
        ),
        title: Builder(
          builder: (context) => Container(
            width: 500,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.03,
              vertical: screenHeight(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  10,
                  (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Egypt"),
                      Radio(
                        activeColor: kMainColor,
                        value: 0,
                        groupValue: 1,
                        onChanged: (val) {
                          MagicRouter.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////

void showblogOptions(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        scrollable: false,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(screenWidth(context) * 0.03),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
        ),
        title: Builder(
          builder: (context) => Container(
            width: 500,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.03,
              vertical: screenHeight(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: TextButton(
                      onPressed: () => MagicRouter.pop(),
                      child: Text(
                        translateString("Close", "اغلاق", "kapat"),
                        style: headingStyle.copyWith(
                          color: kMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth(context) * 0.045,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpace(value: 1),
                  BlocConsumer<BlogsCubit, BlogsState>(
                    listener: (context, state) {},
                    bloc: GetIt.I<BlogsCubit>(),
                    builder: (context, state) {
                      return ListTile(
                        textColor: Colors.black,
                        onTap: () {
                          GetIt.I<BlogsCubit>().getWrittingdata();
                          MagicRouter.navigateTo(const WriteYourBlogScreen());
                        },
                        title: Text(
                          LocaleKeys.WRITTING.tr(),
                          style: headingStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.05,
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
                        title: Text(
                          LocaleKeys.SUCCESS_STORY.tr(),
                          style: headingStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.05,
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
                        onTap: () => GetIt.I<BlogsCubit>().getSuccessStories(1),
                        title: Text(
                          translateString("Tasame Studio", "استوديو تسامي", ""),
                          style: headingStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth(context) * 0.05,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////////////////

void showSpecialicityAlert(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        scrollable: false,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(screenWidth(context) * 0.03),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
        ),
        title: Builder(
          builder: (context) => Container(
            width: 500,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.03,
              vertical: screenHeight(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: TextButton(
                      onPressed: () => MagicRouter.pop(),
                      child: Text(
                        translateString("Close", "اغلاق", "kapat"),
                        style: headingStyle.copyWith(
                          color: kMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth(context) * 0.045,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpace(value: 1),
                  BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {},
                    bloc: GetIt.I<ProfileCubit>(),
                    builder: (context, state) {
                      return Column(
                        children: List.generate(
                            GetIt.I<ProfileCubit>()
                                .specialicityModel!
                                .data!
                                .length,
                            (index) => ListTile(
                                  textColor: Colors.black,
                                  onTap: () => MagicRouter.navigateTo(
                                      TutorRelatedOffersScreen(
                                    tutors: GetIt.I<ProfileCubit>()
                                            .specialicityModel!
                                            .data![index]
                                            .tutors ??
                                        [],
                                  )),
                                  title: Text(
                                    GetIt.I<ProfileCubit>()
                                            .specialicityModel!
                                            .data![index]
                                            .title ??
                                        "",
                                    style: headingStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth(context) * 0.035,
                                    ),
                                  ),
                                )),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
////////////////////////////////////////////////////////////////////////////////

void showExitPopup(BuildContext context, int timeId) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(''),
      content: Text(translateString(
          "You want to cancel Consultation ", "هل تريد الغاء الاستشارة", "")),
      actions: [
        // ignore: deprecated_member_use
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(kMainColor)),
          onPressed: () => MagicRouter.pop(),
          child: Text(
            translateString('No', 'لا', ""),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        // ignore: deprecated_member_use
        BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          bloc: GetIt.I<ProfileCubit>(),
          builder: (context, state) {
            return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(kMainColor)),
              onPressed: () => GetIt.I<ProfileCubit>().postEndRoom(
                timeId,
              ),
              child: Text(
                translateString('Yes', 'نعم', ""),
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ],
    ),
  );
}
