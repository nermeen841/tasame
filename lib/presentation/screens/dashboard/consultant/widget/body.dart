import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/requests/request.dart';
import 'package:zat/presentation/screens/dashboard/consultant/pages/upcomming_consultation/upcomming_consultation.dart';
import '../../../../../core/router/router.dart';
import '../../../../../generator/locale_keys.dart';
import '../../../home/cubit/home_cubit.dart';
import '../../../layout/layuot.dart';
import '../../../myaccount/cubit/profile_cubit.dart';
import '../../../orders/cubit/orders_cubit.dart';
import '../../../orders/orders.dart';
import '../../user/previoseConsultations/previuose_consultations.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
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
                // MagicRouter.pop();
                // MagicRouter.navigateTo(const MyProfileScreen());
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 3,
                ));
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
              //  MagicRouter.navigateTo(const ManageTutorAppointmentScreen())
              GetIt.I<ProfileCubit>().getUserProfile();
              MagicRouter.navigateAndPopAll(const LayoutScreen(
                index: 0,
              ));
            },
            leading: Icon(
              CupertinoIcons.calendar,
              color: colordeepGrey,
              size: screenWidth(context) * 0.08,
            ),
            title: Text(
              translateString(
                  "Manage Appointment", "إدارة المواعيد", "Randevuyu Yönet"),
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
              MagicRouter.navigateTo(
                UpcommingConsultationTutor(
                    fromAuth: false,
                    title: translateString("Upcomming Consultations",
                        "الاستشارات القادمة", "Yaklaşan İstişareler")),
              );
            },
            leading: Icon(
              Icons.computer,
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
              CupertinoIcons.arrow_counterclockwise_circle_fill,
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
          ListTile(
            textColor: Colors.black,
            onTap: () {
              //  MagicRouter.navigateTo(const ManageOffersScreen()),
              GetIt.I<ProfileCubit>().getUserProfile();
              MagicRouter.navigateAndPopAll(const LayoutScreen(
                index: 1,
              ));
            },
            leading: Icon(
              CupertinoIcons.money_dollar_circle_fill,
              color: colordeepGrey,
              size: screenWidth(context) * 0.08,
            ),
            title: Text(
              translateString("Packages", "الباقات", ""),
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
                  CupertinoIcons.money_dollar_circle_fill,
                  color: colordeepGrey,
                  size: screenWidth(context) * 0.08,
                ),
                onTap: () {
                  GetIt.I<OrdersCubit>().getUserOrders();
                  MagicRouter.navigateTo(
                    OrdersScreen(
                      title: translateString(
                          "Package subscriptions", "اشتراكات الباقات", ""),
                    ),
                  );
                },
                title: Text(
                  translateString(
                      "Package subscriptions", "اشتراكات الباقات", ""),
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.05,
                  ),
                ),
              );
            },
          ),
          ListTile(
            textColor: Colors.black,
            onTap: () {
              GetIt.I<HomeCubit>().getAllRequest();
              MagicRouter.navigateTo(
                RequestScreen(
                    title: translateString("Special Appointment Requests",
                        "طلبات المواعيد الخاصة", "")),
              );
            },
            leading: Icon(
              Icons.request_page_outlined,
              color: colordeepGrey,
              size: screenWidth(context) * 0.08,
            ),
            title: Text(
              translateString(
                  "Special Appointment Requests", "طلبات المواعيد الخاصة", ""),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.05,
              ),
            ),
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
          //         LocaleKeys.QUASTIONARE.tr(),
          //         style: headingStyle.copyWith(
          //           fontWeight: FontWeight.bold,
          //           fontSize: screenWidth(context) * 0.05,
          //         ),
          //       ),
          //     );
          //   },
          // ),

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
          //       onTap: () {
          //         GetIt.I<QuastionaireCubit>().getQuastionareOrders();
          //         MagicRouter.navigateTo(const QuastionareOrdersScreen());
          //       },
          //       title: Text(
          //         translateString("Quastionare orders", "طلبات الاستبيان",
          //             "Quartionare siparişleri"),
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
          //       leading: Icon(
          //         CupertinoIcons.book_fill,
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
          //         CupertinoIcons.video_camera_solid,
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
          //     CupertinoIcons.book_fill,
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

          // BlocConsumer<HomeCubit, HomeState>(
          //   listener: (context, state) {},
          //   bloc: GetIt.I<HomeCubit>(),
          //   builder: (context, state) {
          //     return ListTile(
          //       textColor: Colors.black,
          //       leading: Icon(
          //         Icons.bookmark,
          //         color: colordeepGrey,
          //         size: screenWidth(context) * 0.08,
          //       ),
          //       onTap: () {
          //         GetIt.I<HomeCubit>().getFavouriteData();
          //         MagicRouter.navigateTo(const FavouriteScreen());
          //       },
          //       title: Text(
          //         LocaleKeys.MY_FAVOURITE.tr(),
          //         style: headingStyle.copyWith(
          //           fontWeight: FontWeight.bold,
          //           fontSize: screenWidth(context) * 0.05,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
