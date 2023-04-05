import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';

class OfferSliderItem extends StatefulWidget {
  const OfferSliderItem({super.key});

  @override
  State<OfferSliderItem> createState() => _OfferSliderItemState();
}

class _OfferSliderItemState extends State<OfferSliderItem> {
  @override
  void initState() {
    GetIt.I<HomeCubit>().getofferSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return (GetIt.I<HomeCubit>().offersSliderModel != null)
            ? SizedBox(
                width: double.infinity,
                height: screenHeight(context) * 0.4,
                child: Swiper(
                  containerHeight: screenHeight(context) * 0.4,
                  itemHeight: screenHeight(context) * 0.4,
                  itemCount:
                      GetIt.I<HomeCubit>().offersSliderModel!.data!.length,
                  itemBuilder: (context, index) => Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (prefs.getString("user_type") == "user") {
                            if (GetIt.I<HomeCubit>()
                                    .offersSliderModel!
                                    .data![index]
                                    .admin ==
                                "0") {
                              GetIt.I<HomeCubit>().getConsultantDetail(
                                  int.parse(GetIt.I<HomeCubit>()
                                      .offersSliderModel!
                                      .data![index]
                                      .consultantId!
                                      .toString()),
                                  true);
                            } else {
                              GetIt.I<HomeCubit>().getofferTutors(
                                  GetIt.I<HomeCubit>()
                                      .offersSliderModel!
                                      .data![index]
                                      .id!);
                            }
                          }
                        },
                        child: customCachedNetworkImage(
                            url: GetIt.I<HomeCubit>()
                                    .offersSliderModel!
                                    .data![index]
                                    .image ??
                                "",
                            fit: BoxFit.cover,
                            context: context),
                      ),

                      // Container(
                      //   width: screenWidth(context) * 0.7,
                      //   height: (prefs.getString("user_type") == "user")
                      //       ? screenHeight(context) * 0.35
                      //       : screenHeight(context) * 0.25,
                      //   padding: EdgeInsets.symmetric(
                      //     vertical: screenHeight(context) * 0.02,
                      //     horizontal: screenWidth(context) * 0.04,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(
                      //         screenWidth(context) * 0.02),
                      //     color: Colors.white,
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         translateString("Number of consultations",
                      //             "عدد الاستشارات", ""),
                      //       ),
                      //       const VerticalSpace(value: 1),
                      //       Text(
                      //         GetIt.I<HomeCubit>()
                      //                 .offersSliderModel!
                      //                 .data![index]
                      //                 .numConsults ??
                      //             "",
                      //         style: headingStyle.copyWith(
                      //           fontSize: screenWidth(context) * 0.08,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       Text(
                      //         translateString("Price", "السعر", ""),
                      //       ),
                      //       const VerticalSpace(value: 1),
                      //       Text(
                      //         (GetIt.I<HomeCubit>()
                      //                     .offersSliderModel!
                      //                     .data![index]
                      //                     .price !=
                      //                 null)
                      //             ? getPrice(
                      //                 price: num.parse(
                      //                   GetIt.I<HomeCubit>()
                      //                       .offersSliderModel!
                      //                       .data![index]
                      //                       .price!
                      //                       .toString(),
                      //                 ),
                      //               )
                      //             : "",
                      //         style: headingStyle.copyWith(
                      //           fontSize: screenWidth(context) * 0.08,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       (prefs.getString("user_type") == "user")
                      //           ? const VerticalSpace(value: 1)
                      //           : const SizedBox(),
                      //       (prefs.getString("user_type") == "user")
                      //           ? SizedBox(
                      //               width: screenWidth(context) * 0.55,
                      //               height: screenHeight(context) * 0.06,
                      //               child: CustomGeneralButton(
                      //                 text: translateString("Book", "حجز", ""),
                      //                 textColor: Colors.white,
                      //                 onTap: () {
                      //                   if (GetIt.I<HomeCubit>()
                      //                           .offersSliderModel!
                      //                           .data![index]
                      //                           .admin ==
                      //                       "0") {
                      //                     GetIt.I<HomeCubit>()
                      //                         .getConsultantDetail(
                      //                             int.parse(GetIt.I<HomeCubit>()
                      //                                 .offersSliderModel!
                      //                                 .data![index]
                      //                                 .consultantId!
                      //                                 .toString()),
                      //                             true);
                      //                   } else {
                      //                     GetIt.I<HomeCubit>().getofferTutors(
                      //                         GetIt.I<HomeCubit>()
                      //                             .offersSliderModel!
                      //                             .data![index]
                      //                             .id!);
                      //                   }
                      //                   // MagicRouter.navigateTo(
                      //                   //     PaymentTypeSelection(
                      //                   //   orderId: GetIt.I<HomeCubit>()
                      //                   //       .offersSliderModel!
                      //                   //       .data![index]
                      //                   //       .id!,
                      //                   //   fromQuestions: false,
                      //                   // ));
                      //                 },
                      //               ),
                      //             )
                      //           : const SizedBox(),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  autoplay: false,
                  // autoplayDelay: 5000,
                ),
              )
            : const SizedBox();
      },
    );
  }
}
