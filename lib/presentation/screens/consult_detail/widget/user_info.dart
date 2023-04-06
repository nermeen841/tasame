// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/auth/bloc/Auth_cubit/auth_cubit.dart';
import 'package:zat/presentation/screens/consult_detail/widget/video_player.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/space_widget.dart';
import 'about_user.dart';

class ConsultantInfoCard extends StatefulWidget {
  const ConsultantInfoCard({Key? key}) : super(key: key);

  @override
  State<ConsultantInfoCard> createState() => _ConsultantInfoCardState();
}

class _ConsultantInfoCardState extends State<ConsultantInfoCard> {
  String? countryflag;
  @override
  void initState() {
    GetIt.I<AuthCubit>().getcountry().then((value) {
      if (GetIt.I<AuthCubit>().countryModel != null) {
        for (var element in GetIt.I<AuthCubit>().countryModel!.data!) {
          if (element.name ==
              GetIt.I<HomeCubit>().consultantDetailModel!.data!.countryName!) {
            setState(() {
              countryflag = element.image!;
            });
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: screenWidth(context) * 0.3,
                  height: screenHeight(context) * 0.15,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(screenWidth(context) * 0.01),
                    child: customCachedNetworkImage(
                      context: context,
                      url: GetIt.I<HomeCubit>()
                          .consultantDetailModel!
                          .data!
                          .image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const HorizontalSpace(value: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.45,
                          child: Text(
                            GetIt.I<HomeCubit>()
                                .consultantDetailModel!
                                .data!
                                .name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: headingStyle.copyWith(
                                color: colordeepGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth(context) * 0.04),
                          ),
                        ),

                        (countryflag != null)
                            ? CircleAvatar(
                                radius: screenWidth(context) * 0.04,
                                backgroundColor: mainColor,
                                backgroundImage: NetworkImage(countryflag!),
                              )
                            : const SizedBox(),
                        // const HorizontalSpace(value: 13),
                        // (prefs.getString("user_type") == "user")
                        //     ? InkWell(
                        //         onTap: () {
                        //           GetIt.I<HomeCubit>().postAddRemoveFavourite(
                        //               tutorID: GetIt.I<HomeCubit>()
                        //                   .consultantDetailModel!
                        //                   .data!
                        //                   .id!);
                        //         },
                        //         child: Icon(
                        //           (GetIt.I<HomeCubit>().isFavourite[
                        //                       GetIt.I<HomeCubit>()
                        //                           .consultantDetailModel!
                        //                           .data!
                        //                           .id!] ==
                        //                   true)
                        //               ? Icons.favorite
                        //               : Icons.favorite_border,
                        //           color: (GetIt.I<HomeCubit>().isFavourite[
                        //                       GetIt.I<HomeCubit>()
                        //                           .consultantDetailModel!
                        //                           .data!
                        //                           .id!] ==
                        //                   true)
                        //               ? kMainColor
                        //               : kMainColor,
                        //         ),
                        //       )
                        //     : const SizedBox(),
                      ],
                    ),
                    const VerticalSpace(value: 1),
                    (GetIt.I<HomeCubit>()
                                .consultantDetailModel!
                                .data!
                                .tutorBio !=
                            null)
                        ? SizedBox(
                            width: screenWidth(context) * 0.55,
                            child: Text(
                              GetIt.I<HomeCubit>()
                                  .consultantDetailModel!
                                  .data!
                                  .tutorBio!,
                              maxLines: 10,
                              overflow: TextOverflow.fade,
                              style: headingStyle.copyWith(
                                fontSize: screenWidth(context) * 0.035,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    (GetIt.I<HomeCubit>()
                                .consultantDetailModel!
                                .data!
                                .tutorBio !=
                            null)
                        ? const VerticalSpace(value: 1)
                        : const SizedBox(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RatingBar(
                          ignoreGestures: true,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.amber,
                            ),
                          ),
                          initialRating: double.parse(GetIt.I<HomeCubit>()
                                  .consultantDetailModel!
                                  .data!
                                  .rate ??
                              ""),
                          itemCount: 5,
                          itemSize: screenWidth(context) * 0.03,
                          onRatingUpdate: (double value) {},
                        ),
                      ],
                    ),
                    const VerticalSpace(value: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (GetIt.I<HomeCubit>()
                                .consultantDetailModel!
                                .data!
                                .languages!
                                .isNotEmpty)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(translateString(
                                      "I speak : ", "أتحدث : ", "")),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      GetIt.I<HomeCubit>()
                                          .consultantDetailModel!
                                          .data!
                                          .languages!
                                          .length,
                                      (index) => Row(
                                        children: [
                                          Text(GetIt.I<HomeCubit>()
                                              .consultantDetailModel!
                                              .data!
                                              .languages![index]
                                              .name!),
                                          (index !=
                                                  GetIt.I<HomeCubit>()
                                                          .consultantDetailModel!
                                                          .data!
                                                          .languages!
                                                          .length -
                                                      1)
                                              ? const Text(" - ")
                                              : const SizedBox(),
                                          const HorizontalSpace(value: 0.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const VerticalSpace(value: 1),
                        (GetIt.I<HomeCubit>()
                                        .consultantDetailModel!
                                        .data!
                                        .specialties !=
                                    null &&
                                GetIt.I<HomeCubit>()
                                    .consultantDetailModel!
                                    .data!
                                    .specialties!
                                    .isNotEmpty)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  GetIt.I<HomeCubit>()
                                      .consultantDetailModel!
                                      .data!
                                      .specialties!
                                      .length,
                                  (index) => Text(
                                    GetIt.I<HomeCubit>()
                                            .consultantDetailModel!
                                            .data!
                                            .specialties![index]
                                            .name ??
                                        "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: headingStyle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: colordeepGrey,
                                      fontSize: screenWidth(context) * 0.035,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        // SizedBox(
                        //   width: screenWidth(context) * 0.33,
                        //   height: screenHeight(context) * 0.04,
                        //   child: CustomGeneralButton(
                        //     onTap: () {
                        //       if (GetIt.I<HomeCubit>()
                        //               .consultantDetailModel!
                        //               .data!
                        //               .isRegistered ==
                        //           true) {
                        //         MagicRouter.navigateTo(ChatBodyScreen(
                        //           recieverId: GetIt.I<HomeCubit>()
                        //               .consultantDetailModel!
                        //               .data!
                        //               .id!,
                        //           recieverImage: GetIt.I<HomeCubit>()
                        //               .consultantDetailModel!
                        //               .data!
                        //               .image!,
                        //           recieverName: GetIt.I<HomeCubit>()
                        //               .consultantDetailModel!
                        //               .data!
                        //               .name!,
                        //         ));
                        //       } else {
                        //         showToast(
                        //             msg: translateString(
                        //                 "You must make an appointment or sign up for an offer to communicate with the counsultant",
                        //                 "يجب تحديد موعد او الاشتراك في عرض للتواصل مع المستشار",
                        //                 "Danışmanla iletişim kurmak için randevu almalı veya bir teklife kaydolmalısınız."),
                        //             state: ToastStates.ERROR);
                        //       }
                        //     },
                        //     text: LocaleKeys.SEND_MESSAGE.tr(),
                        //     color: colorRed,
                        //     borderColor: Colors.transparent,
                        //     textColor: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const VerticalSpace(value: 2),
            (GetIt.I<HomeCubit>().consultantDetailModel!.data!.video != null &&
                    GetIt.I<HomeCubit>().consultantDetailModel!.data!.video !=
                        "")
                ? VideoPlayerItem(
                    videoUrl: GetIt.I<HomeCubit>()
                        .consultantDetailModel!
                        .data!
                        .video!)
                : const SizedBox(),
            const VerticalSpace(value: 2),
            const AboutUser(),
          ],
        );
      },
    );
  }
}
