// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/plans_and_prices/pages/payment_type_selection.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../home/cubit/home_cubit.dart';

class ConsultantOffers extends StatefulWidget {
  const ConsultantOffers({Key? key}) : super(key: key);

  @override
  State<ConsultantOffers> createState() => _ConsultantOffersState();
}

class _ConsultantOffersState extends State<ConsultantOffers> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context) * 0.02,
            vertical: screenHeight(context) * 0.02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth(context) * 0.02),
          ),
          child: (GetIt.I<HomeCubit>()
                  .consultantDetailModel!
                  .data!
                  .offers!
                  .isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translateString("Packages", "الباقات", "teklifler"),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.05,
                        color: colorBlue,
                      ),
                    ),
                    const VerticalSpace(value: 2),
                    Center(
                      child: Wrap(
                        runSpacing: 7,
                        spacing: 7,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          GetIt.I<HomeCubit>()
                              .consultantDetailModel!
                              .data!
                              .offers!
                              .length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              width: screenWidth(context) * 0.35,
                              height: screenHeight(context) * 0.12,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colordeepGrey,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth(context) * 0.01),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth(context) * 0.017,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${translateString("Num of consultant: ", "عدد الاستشارات", "danışman sayısı")} ${GetIt.I<HomeCubit>().consultantDetailModel!.data!.offers![index].numConsults!}",
                                          style: headingStyle.copyWith(
                                            color: colordeepGrey,
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                screenWidth(context) * 0.03,
                                          ),
                                        ),
                                        const VerticalSpace(value: 1),
                                        Text(
                                          "${translateString("price: ", "السعر : ", "fiyat")} ${getPrice(price: num.parse(GetIt.I<HomeCubit>().consultantDetailModel!.data!.offers![index].price!))}",
                                          style: headingStyle.copyWith(
                                            color: colordeepGrey,
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                screenWidth(context) * 0.03,
                                          ),
                                        ),
                                        const VerticalSpace(value: 1),
                                      ],
                                    ),
                                  ),
                                  (prefs.getString("user_type") == "user")
                                      ? SizedBox(
                                          width: screenWidth(context) * 0.35,
                                          height: screenHeight(context) * 0.035,
                                          child: CustomGeneralButton(
                                            text: LocaleKeys.BOOK.tr(),
                                            color: colorBlue,
                                            textColor: Colors.white,
                                            fontSize:
                                                screenWidth(context) * 0.035,
                                            onTap: () {
                                              MagicRouter.navigateTo(
                                                  PaymentTypeSelection(
                                                orderId: GetIt.I<HomeCubit>()
                                                    .consultantDetailModel!
                                                    .data!
                                                    .offers![index]
                                                    .id!,
                                                fromQuestions: false,
                                              ));
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    translateString("no offers yet", "لا توجد عروض بعد",
                        "henüz teklif yok"),
                    style: headingStyle.copyWith(
                      color: kMainColor,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
