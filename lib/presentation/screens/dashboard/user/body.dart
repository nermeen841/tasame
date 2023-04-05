import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/dashboard/user/previoseConsultations/previuose_consultations.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';
import '../../../../generator/locale_keys.dart';
import '../../favourite/favourite.dart';
import '../../home/cubit/home_cubit.dart';
import '../../layout/layuot.dart';
import '../../myaccount/myaccount.dart';
import '../../orders/cubit/orders_cubit.dart';
import '../../orders/orders.dart';
import '../../qustionare/cubit/quastionaire_cubit.dart';
import '../../qustionare/widget/orders.dart';

class UserDashBoardScreen extends StatefulWidget {
  const UserDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
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
          ListTile(
            textColor: Colors.black,
            onTap: () {
              dialog(context);
              GetIt.I<ProfileCubit>().getUserProfile().then((value) {
                MagicRouter.pop();
                MagicRouter.navigateTo(const MyProfileScreen());
              });
            },
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: colordeepGrey,
              size: screenWidth(context) * 0.08,
            ),
            title: Text(
              LocaleKeys.MY_PROFILE.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.05,
              ),
            ),
          ),
          ListTile(
            textColor: Colors.black,
            onTap: () {
              GetIt.I<ProfileCubit>().getUserProfile();
              MagicRouter.navigateAndPopAll(const LayoutScreen(
                index: 4,
              ));
              // MagicRouter.navigateTo(
              //   UpcommingConsultationsScreen(
              //       fromAuth: false,
              //       title: translateString("Upcomming Consultations",
              //           "الاستشارات القادمة", "Yaklaşan İstişareler")),
              // );
            },
            leading: Icon(
              Icons.computer_outlined,
              color: colordeepGrey,
              size: screenWidth(context) * 0.08,
            ),
            title: Text(
              translateString("Upcomming Consultations", "الاستشارات القادمة",
                  "Yaklaşan İstişareler"),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.05,
              ),
            ),
          ),
          ListTile(
            textColor: Colors.black,
            onTap: () {
              GetIt.I<OrdersCubit>().getuserBookingData();
              MagicRouter.navigateTo(
                PreviouseConsultationsScreen(
                    title: translateString("Prevoiuse Consultations",
                        "الاستشارات السابقة", "Önceki Konsültasyonlar")),
              );
            },
            leading: Icon(
              CupertinoIcons.arrow_counterclockwise_circle,
              size: screenWidth(context) * 0.08,
              color: colordeepGrey,
            ),
            title: Text(
              translateString("Prevoiuse Consultations", "الاستشارات السابقة",
                  "Önceki Konsültasyonlar"),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.05,
              ),
            ),
          ),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) {},
            bloc: GetIt.I<OrdersCubit>(),
            builder: (context, state) {
              return ListTile(
                textColor: Colors.black,
                leading: Icon(
                  CupertinoIcons.money_dollar_circle,
                  color: colordeepGrey,
                  size: screenWidth(context) * 0.08,
                ),
                onTap: () {
                  GetIt.I<OrdersCubit>().getUserOrders();
                  MagicRouter.navigateTo(
                    OrdersScreen(
                        title: translateString(
                            "packages Requests", "الباقات", "")),
                  );
                },
                title: Text(
                  (prefs.getString("user_type") == "user")
                      ? translateString("packages Requests", "الباقات", "")
                      : translateString("consultations Request",
                          "طلبات الاستشارة", "istişare Talebi"),
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.05,
                  ),
                ),
              );
            },
          ),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            bloc: GetIt.I<HomeCubit>(),
            builder: (context, state) {
              return ListTile(
                textColor: Colors.black,
                leading: Icon(
                  Icons.bookmark_border_outlined,
                  color: colordeepGrey,
                  size: screenWidth(context) * 0.08,
                ),
                onTap: () {
                  GetIt.I<HomeCubit>().getFavouriteData();
                  MagicRouter.navigateTo(const FavouriteScreen());
                },
                title: Text(
                  LocaleKeys.MY_FAVOURITE.tr(),
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.05,
                  ),
                ),
              );
            },
          ),
          // BlocConsumer<QuastionaireCubit, QuastionaireState>(
          //   listener: (context, state) {},
          //   bloc: GetIt.I<QuastionaireCubit>(),
          //   builder: (context, state) {
          //     return ListTile(
          //       textColor: Colors.black,
          //       leading: Icon(
          //         CupertinoIcons.list_bullet_below_rectangle,
          //         color: colordeepGrey,
          //         size: screenWidth(context) * 0.08,
          //       ),
          //       onTap: () => GetIt.I<QuastionaireCubit>().getQuastionare(),
          //       title: Text(
          //         translateString("Scales", "المقاييس", ""),
          //         // LocaleKeys.QUASTIONARE.tr(),
          //         style: headingStyle.copyWith(
          //           fontWeight: FontWeight.bold,
          //           fontSize: screenWidth(context) * 0.05,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          BlocConsumer<QuastionaireCubit, QuastionaireState>(
            listener: (context, state) {},
            bloc: GetIt.I<QuastionaireCubit>(),
            builder: (context, state) {
              return ListTile(
                textColor: Colors.black,
                leading: Icon(
                  CupertinoIcons.list_bullet_below_rectangle,
                  color: colordeepGrey,
                  size: screenWidth(context) * 0.08,
                ),
                onTap: () {
                  GetIt.I<QuastionaireCubit>().getQuastionareOrders();
                  MagicRouter.navigateTo(const QuastionareOrdersScreen());
                },
                title: Text(
                  translateString("Record metrics", "سجل المقاييس", ""),
                  // translateString("Quastionare orders", "طلبات الاستبيان",
                  //     "Quartionare siparişleri"),
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.05,
                  ),
                ),
              );
            },
          ),
          // BlocConsumer<BlogsCubit, BlogsState>(
          //   listener: (context, state) {},
          //   bloc: GetIt.I<BlogsCubit>(),
          //   builder: (context, state) {
          //     return ListTile(
          //       textColor: Colors.black,
          //       leading: Icon(
          //         CupertinoIcons.book,
          //         color: colordeepGrey,
          //         size: screenWidth(context) * 0.08,
          //       ),
          //       onTap: () {
          //         GetIt.I<BlogsCubit>().getWrittingdata();
          //         MagicRouter.navigateTo(const WriteYourBlogScreen());
          //       },
          //       title: Text(
          //         LocaleKeys.WRITTING.tr(),
          //         style: headingStyle.copyWith(
          //           fontWeight: FontWeight.bold,
          //           fontSize: screenWidth(context) * 0.05,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // BlocConsumer<BlogsCubit, BlogsState>(
          //   listener: (context, state) {},
          //   bloc: GetIt.I<BlogsCubit>(),
          //   builder: (context, state) {
          //     return ListTile(
          //       textColor: Colors.black,
          //       onTap: () {
          //         GetIt.I<BlogsCubit>().getSuccessStories(0);
          //       },
          //       leading: Icon(
          //         CupertinoIcons.video_camera,
          //         color: colordeepGrey,
          //         size: screenWidth(context) * 0.08,
          //       ),
          //       title: Text(
          //         LocaleKeys.SUCCESS_STORY.tr(),
          //         style: headingStyle.copyWith(
          //           fontWeight: FontWeight.bold,
          //           fontSize: screenWidth(context) * 0.05,
          //         ),
          //       ),
          //     );
          //   },
          // ),

          // ListTile(
          //   textColor: Colors.black,
          //   onTap: () => showblogOptions(context),
          //   leading: Icon(
          //     CupertinoIcons.book,
          //     color: colordeepGrey,
          //     size: screenWidth(context) * 0.08,
          //   ),
          //   title: Text(
          //     LocaleKeys.OUR_BLOG.tr(),
          //     style: headingStyle.copyWith(
          //       fontWeight: FontWeight.bold,
          //       fontSize: screenWidth(context) * 0.05,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
