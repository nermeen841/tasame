// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/qustionare/cubit/quastionaire_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../orders/cubit/orders_cubit.dart';
import '../../orders/widget/promo_code.dart';

class PaymentsMedthods extends StatefulWidget {
  final bool fromQuestions;
  final int? quastionareId;
  final int? orderId;
  const PaymentsMedthods(
      {Key? key, required this.fromQuestions, this.quastionareId, this.orderId})
      : super(key: key);

  @override
  State<PaymentsMedthods> createState() => _PaymentsMedthodsState();
}

class _PaymentsMedthodsState extends State<PaymentsMedthods> {
  @override
  void initState() {
    GetIt.I<QuastionaireCubit>().getPaymentTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuastionaireCubit, QuastionaireState>(
      listener: (context, state) {
        // if (state is MakeQuestionareSuccesstate) {
        //   MagicRouter.navigateTo(
        //     PaymentGatway(
        //       url: GetIt.I<QuastionaireCubit>()
        //           .makeQuastionareOrderModel!
        //           .data!
        //           .redirectUrl!,
        //       id: widget.quastionareId!,
        //       fromQuastionare: true,
        //     ),
        //   );
        // }
      },
      bloc: GetIt.I<QuastionaireCubit>(),
      builder: (context, state) {
        return (GetIt.I<QuastionaireCubit>().paymentTypesModel != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  GetIt.I<QuastionaireCubit>().paymentTypesModel!.data!.length,
                  (index) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print(GetIt.I<QuastionaireCubit>()
                              .paymentTypesModel!
                              .data![index]
                              .id!);
                          print(widget.quastionareId);
                          if (widget.fromQuestions == true) {
                            // GetIt.I<QuastionaireCubit>().postMakeQuestionare(
                            //   paymentType: GetIt.I<QuastionaireCubit>()
                            //       .paymentTypesModel!
                            //       .data![index]
                            //       .id!,
                            //   questionareId: widget.quastionareId!,
                            // );
                          } else {
                            if (GetIt.I<QuastionaireCubit>()
                                    .paymentTypesModel!
                                    .data![index]
                                    .id! ==
                                2) {
                              MagicRouter.navigateTo(const PromoCodeScreen());
                            } else {
                              GetIt.I<OrdersCubit>().postMakeOrder(
                                paymentTypeId: GetIt.I<QuastionaireCubit>()
                                    .paymentTypesModel!
                                    .data![index]
                                    .id!,
                                offerID: widget.orderId!,
                              );
                            }
                          }
                        },
                        child: paymentMethodItem(
                          title: GetIt.I<QuastionaireCubit>()
                              .paymentTypesModel!
                              .data![index]
                              .name!,
                          content: "",
                          iconData: FontAwesomeIcons.wallet,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                    ],
                  ),
                ),
              )
            : loading();
      },
    );
  }

  /////////////////////////////////////////////////////////////////

  Widget paymentMethodItem({
    required String title,
    required String content,
    required IconData iconData,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.04,
        vertical: screenHeight(context) * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth(context) * 0.015),
        border: Border.all(
          color: colorGrey.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: colorGrey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: kMainColor,
          ),
          const HorizontalSpace(value: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                ),
              ),
              // const VerticalSpace(value: 1),
              // SizedBox(
              //   width: screenWidth(context) * 0.7,
              //   child: Text(
              //     content,
              //     style: headingStyle.copyWith(
              //       color: Colors.grey,
              //       fontWeight: FontWeight.w400,
              //       fontSize: screenWidth(context) * 0.035,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
