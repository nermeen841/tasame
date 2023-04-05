import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/qustionare/cubit/quastionaire_cubit.dart';

class QuastionareBody extends StatefulWidget {
  const QuastionareBody({Key? key}) : super(key: key);

  @override
  State<QuastionareBody> createState() => _QuastionareBodyState();
}

class _QuastionareBodyState extends State<QuastionareBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<QuastionaireCubit>().getQuastionare(),
      child: BlocConsumer<QuastionaireCubit, QuastionaireState>(
        listener: (context, state) {},
        bloc: GetIt.I<QuastionaireCubit>(),
        builder: (context, state) {
          return (GetIt.I<QuastionaireCubit>().quastionarModel != null)
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.04,
                    vertical: screenHeight(context) * 0.02,
                  ),
                  child: (GetIt.I<QuastionaireCubit>()
                          .quastionarModel!
                          .data!
                          .isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            GetIt.I<QuastionaireCubit>()
                                .quastionarModel!
                                .data!
                                .length,
                            (index) => Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    GetIt.I<QuastionaireCubit>()
                                        .postMakeQuestionare(
                                      questionareId:
                                          GetIt.I<QuastionaireCubit>()
                                              .quastionarModel!
                                              .data![index]
                                              .id!,
                                      paymentType: 1,
                                    );
                                  },
                                  child: quastionareItem(
                                      GetIt.I<QuastionaireCubit>()
                                          .quastionarModel!
                                          .data![index]
                                          .title!,
                                      GetIt.I<QuastionaireCubit>()
                                          .quastionarModel!
                                          .data![index]
                                          .price!),
                                ),
                                const VerticalSpace(value: 2),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            translateString("There are no metrics yet",
                                "لا يوجد مقاييس بعد ", ""),
                            style: headingStyle.copyWith(
                              color: kMainColor,
                            ),
                          ),
                        ),
                )
              : loading();
        },
      ),
    );
  }

  Widget quastionareItem(String title, price) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.02,
        vertical: screenHeight(context) * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth(context) * 0.015),
        color: Colors.white,
        border: Border.all(
          color: colorGrey.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              const VerticalSpace(value: 1),
              Text(
                "${translateString("price : ", "السعر : ", "")} :  ${getPrice(price: num.parse(price.toString()))}",
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: colordeepGrey,
          ),
        ],
      ),
    );
  }
}
