import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/constants.dart';
import '../../../../../myaccount/cubit/profile_cubit.dart';
import 'offer_item.dart';

class ShowTutorOffers extends StatelessWidget {
  const ShowTutorOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        bloc: GetIt.I<ProfileCubit>(),
        builder: (context, state) {
          return (GetIt.I<ProfileCubit>().tutorProfileModel == null)
              ? loading()
              : (GetIt.I<ProfileCubit>()
                      .tutorProfileModel!
                      .data!
                      .offers!
                      .isNotEmpty)
                  ? Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: List.generate(
                        GetIt.I<ProfileCubit>()
                            .tutorProfileModel!
                            .data!
                            .offers!
                            .length,
                        (index) => OfferItem(
                          offerID: GetIt.I<ProfileCubit>()
                              .tutorProfileModel!
                              .data!
                              .offers![index]
                              .id!,
                          numOfConsultations: GetIt.I<ProfileCubit>()
                              .tutorProfileModel!
                              .data!
                              .offers![index]
                              .numConsults!
                              .toString(),
                          price: getPrice(
                              price: num.parse(GetIt.I<ProfileCubit>()
                                  .tutorProfileModel!
                                  .data!
                                  .offers![index]
                                  .price!
                                  .toString())),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        translateString(
                            "no packages here yet", "لا توجد باقات  بعد", ""),
                        style: headingStyle.copyWith(
                          color: kMainColor,
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
