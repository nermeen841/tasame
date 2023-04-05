// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/qustionare/cubit/quastionaire_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';

import '../../../../core/constants/constants.dart';

class QuastionareOrdersBody extends StatefulWidget {
  const QuastionareOrdersBody({Key? key}) : super(key: key);

  @override
  State<QuastionareOrdersBody> createState() => _QuastionareOrdersBodyState();
}

class _QuastionareOrdersBodyState extends State<QuastionareOrdersBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuastionaireCubit, QuastionaireState>(
      listener: (context, state) {},
      bloc: GetIt.I<QuastionaireCubit>(),
      builder: (context, state) {
        return (GetIt.I<QuastionaireCubit>().quastionareOrdersModel != null)
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 0.04,
                  vertical: screenHeight(context) * 0.02,
                ),
                child: (GetIt.I<QuastionaireCubit>()
                        .quastionareOrdersModel!
                        .data!
                        .isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          GetIt.I<QuastionaireCubit>()
                              .quastionareOrdersModel!
                              .data!
                              .length,
                          (index) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context) * 0.02,
                              vertical: screenHeight(context) * 0.015,
                            ),
                            margin: EdgeInsets.all(
                              screenWidth(context) * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                screenWidth(context) * 0.015,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorGrey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.bagShopping,
                                  color: kMainColor,
                                ),
                                const HorizontalSpace(value: 1),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      GetIt.I<QuastionaireCubit>()
                                          .quastionareOrdersModel!
                                          .data![index]
                                          .questionnairTitle!,
                                      style: headingStyle.copyWith(
                                        color: colordeepGrey,
                                        fontSize: screenWidth(context) * 0.04,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const VerticalSpace(value: 0.7),
                                    Text(
                                      translateString("price : ", "السعر : ",
                                              "fiyat : ") +
                                          " " +
                                          getPrice(
                                            price: num.parse(
                                                GetIt.I<QuastionaireCubit>()
                                                    .quastionareOrdersModel!
                                                    .data![index]
                                                    .price!
                                                    .toString()),
                                          ),
                                      style: headingStyle.copyWith(
                                        color: colordeepGrey,
                                        fontSize: screenWidth(context) * 0.04,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const VerticalSpace(value: 0.7),
                                    Text(
                                      translateString("payment type : ",
                                              "طريقة الدفع : ", "ödeme türü") +
                                          " " +
                                          GetIt.I<QuastionaireCubit>()
                                              .quastionareOrdersModel!
                                              .data![index]
                                              .payment!,
                                      style: headingStyle.copyWith(
                                        color: colordeepGrey,
                                        fontSize: screenWidth(context) * 0.04,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          translateString("No metrics record yet",
                              "لا يوجد سجل مقاييس بعد ", ""),
                          style: headingStyle.copyWith(
                            color: kMainColor,
                          ),
                        ),
                      ),
              )
            : loading();
      },
    );
  }
}
