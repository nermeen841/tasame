import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../widget/person_card.dart';
import '../../home/cubit/home_cubit.dart';

class TutorsOfferList extends StatefulWidget {
  const TutorsOfferList({Key? key}) : super(key: key);

  @override
  State<TutorsOfferList> createState() => _TutorsOfferListState();
}

class _TutorsOfferListState extends State<TutorsOfferList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return (GetIt.I<HomeCubit>().allConsultantOffersModel == null)
            ? loading()
            : (GetIt.I<HomeCubit>().allConsultantOffersModel!.data!.isNotEmpty)
                ? GridView.builder(
                    shrinkWrap: true,
                    primary: true,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight(context) * 0.02,
                      horizontal: screenWidth(context) * 0.02,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.6),
                    itemBuilder: (context, index) => PersonCard(
                      counsultantID: GetIt.I<HomeCubit>()
                          .allConsultantOffersModel!
                          .data![index]
                          .id!,
                      name: GetIt.I<HomeCubit>()
                          .allConsultantOffersModel!
                          .data![index]
                          .name!,
                      image: GetIt.I<HomeCubit>()
                          .allConsultantOffersModel!
                          .data![index]
                          .image!,
                      rate: GetIt.I<HomeCubit>()
                          .allConsultantOffersModel!
                          .data![index]
                          .rate!
                          .toString(),
                      fromfavourite: GetIt.I<HomeCubit>()
                              .allConsultantOffersModel!
                              .data![index]
                              .isFav ??
                          false,
                      lang: GetIt.I<HomeCubit>()
                          .allConsultantOffersModel!
                          .data![index]
                          .languages!,
                    ),
                    itemCount: GetIt.I<HomeCubit>()
                        .allConsultantOffersModel!
                        .data!
                        .length,
                  )
                : Center(
                    child: Text(
                      translateString(
                          "no consultant here", "لا يوجد مستشارين", ""),
                      style: headingStyle.copyWith(
                        color: kMainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.045,
                      ),
                    ),
                  );
      },
    );
  }
}
