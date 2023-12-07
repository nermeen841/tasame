import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/blogs%20screens/pages/success_story.dart';
import 'package:zat/presentation/screens/contactus/contactus.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import 'package:zat/presentation/screens/info/info.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/partner/partner.dart';
import 'package:zat/presentation/screens/qustionare/widget/orders.dart';
import 'package:zat/presentation/widget/screen_title.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../all_consultant/all_consultant.dart';
import '../../blogs screens/cubit/blogs_cubit.dart';
import '../../blogs screens/pages/write_your_blog.dart';
import '../../contactus/cubit/setting_cubit.dart';
import '../../qustionare/cubit/quastionaire_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../tutor_offers/tutor_offers.dart';

class MenueBody extends StatefulWidget {
  const MenueBody({super.key});

  @override
  State<MenueBody> createState() => _MenueBodyState();
}

class _MenueBodyState extends State<MenueBody> {
  String? title;
  String? content;
  String? image;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.04,
        vertical: screenHeight(context) * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScreenTitle(
            title: translateString("Menue", "القائمة", ""),
          ),
          const VerticalSpace(value: 1),
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
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: InfoScreen(
                            showAppbar: true,
                            image: image,
                            title:
                                translateString("About Tasame", "عن تسامي", ""),
                            content: content!,
                          ),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      // => MagicRouter.navigateTo(
                      // InfoScreen(
                      //   image: image,
                      //   title:
                      //       translateString("About Tasame", "عن تسامي", ""),
                      //   content: content!,
                      // ),
                      // ),
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
              GetIt.I<ProfileCubit>().getSpecialicity().then(
                    (value) => homeBottomSheet(
                      context: context,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
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
                                            onTap: () =>
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                              context,
                                              screen: TutorRelatedOffersScreen(
                                                showAppbar: true,
                                                tutors: GetIt.I<ProfileCubit>()
                                                        .specialicityModel!
                                                        .data![index]
                                                        .tutors ??
                                                    [],
                                              ),
                                              withNavBar: true,
                                            ),
                                            title: Text(
                                              GetIt.I<ProfileCubit>()
                                                      .specialicityModel!
                                                      .data![index]
                                                      .title ??
                                                  "",
                                              style: headingStyle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth(context) *
                                                    0.035,
                                              ),
                                            ),
                                          )),
                                );
                              },
                            ),
                            const ListTile(
                              title: Text(""),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
            },
            title: Text(
              translateString("Consultations", "الاستشارات", ""),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
          ),
          ListTile(
            textColor: Colors.black,
            onTap: () {
              GetIt.I<HomeCubit>().getAllConsultant();
              if (prefs.getString("user_type") == "user") {
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 1,
                ));
              } else {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const AllConsultantScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              }
            },
            title: Text(
              translateString("Consultants", "المستشارون", ""),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
          ),
          // (prefs.getString("user_type") == "user")
          //     ? BlocConsumer<QuastionaireCubit, QuastionaireState>(
          //         listener: (context, state) {},
          //         bloc: GetIt.I<QuastionaireCubit>(),
          //         builder: (context, state) {
          //           return ListTile(
          //             textColor: Colors.black,
          //             onTap: () async {
          //               await GetIt.I<QuastionaireCubit>()
          //                   .getQuastionare()
          //                   .then((value) {
          //                 MagicRouter.navigateAndPopAll(const LayoutScreen(
          //                   index: 3,
          //                 ));
          //               });
          //             },
          //             title: Text(
          //               translateString("Scales", "المقاييس", ""),
          //               // LocaleKeys.QUASTIONARE.tr(),
          //               style: headingStyle.copyWith(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: screenWidth(context) * 0.04,
          //               ),
          //             ),
          //           );
          //         },
          //       )
          //     : const SizedBox(),
          (prefs.getString("user_type") == "user")
              ? BlocConsumer<QuastionaireCubit, QuastionaireState>(
                  listener: (context, state) {},
                  bloc: GetIt.I<QuastionaireCubit>(),
                  builder: (context, state) {
                    return ListTile(
                      textColor: Colors.black,
                      onTap: () {
                        GetIt.I<QuastionaireCubit>().getQuastionareOrders();
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const QuastionareOrdersScreen(),
                          withNavBar: true,
                        );
                      },
                      title: Text(
                        translateString("Metrices Records", "سجل المقاييس", ""),
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
                onTap: () {
                  GetIt.I<BlogsCubit>().getWrittingdata();
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const WriteYourBlogScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
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
                  GetIt.I<BlogsCubit>()
                      .getSuccessStories(0)
                      .then((value) => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const SuccessStoriesScreen(isAdmin: 0),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ));
                },
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
                  GetIt.I<BlogsCubit>()
                      .getSuccessStories(1)
                      .then((value) => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const SuccessStoriesScreen(isAdmin: 1),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ));
                },
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
          ListTile(
            textColor: Colors.black,
            onTap: () async {
              dialog(context);
              await GetIt.I<HomeCubit>().getPartner().then((value) {
                MagicRouter.pop();
                GetIt.I<BlogsCubit>()
                    .getSuccessStories(0)
                    .then((value) => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const PartnerScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ));
              });
            },
            title: Text(
              translateString("Credits and partners", "شركاؤنا", ""),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
          ),
          ListTile(
            textColor: Colors.black,
            onTap: () => PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const ContactUsScreen(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            ),
            title: Text(
              LocaleKeys.CONTACT_US.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
          ),
          const ListTile(
            title: Text(""),
          ),
        ],
      ),
    );
  }
}
