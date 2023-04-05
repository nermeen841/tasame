import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/generator/locale_keys.dart';
import '../../../widget/person_card.dart';
import '../../home/cubit/home_cubit.dart';

class FavouriteBody extends StatefulWidget {
  const FavouriteBody({Key? key}) : super(key: key);

  @override
  State<FavouriteBody> createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<HomeCubit>().getFavouriteData(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.02,
        ),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is AddRemoveFromFavouriteSuccessState) {
              GetIt.I<HomeCubit>().getFavouriteData();
            }
          },
          bloc: GetIt.I<HomeCubit>(),
          builder: (context, state) {
            return (state is! GetFavouriteLoadingState)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenHeight(context) * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              screenWidth(context) * 0.01),
                          boxShadow: [
                            BoxShadow(
                              color: colorGrey.withOpacity(0.2),
                              offset: const Offset(0, 1),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.FAVOURITE_MESSAGE.tr(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const VerticalSpace(value: 3),
                      (GetIt.I<HomeCubit>().favouriteModel!.data!.isNotEmpty)
                          ? GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      childAspectRatio: 0.6),
                              itemBuilder: (context, index) => PersonCard(
                                fromfavourite: true,
                                image: GetIt.I<HomeCubit>()
                                        .favouriteModel!
                                        .data![index]
                                        .image ??
                                    "",
                                lang: GetIt.I<HomeCubit>()
                                    .favouriteModel!
                                    .data![index]
                                    .languages!,
                                name: GetIt.I<HomeCubit>()
                                    .favouriteModel!
                                    .data![index]
                                    .name!,
                                rate: GetIt.I<HomeCubit>()
                                    .favouriteModel!
                                    .data![index]
                                    .rate!,
                                counsultantID: GetIt.I<HomeCubit>()
                                    .favouriteModel!
                                    .data![index]
                                    .id!,
                              ),
                              itemCount: GetIt.I<HomeCubit>()
                                  .favouriteModel!
                                  .data!
                                  .length,
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.2,
                              ),
                              child: Center(
                                child: Text(
                                  translateString("No Tutors here yet ",
                                      "لا يوجد مستشارين في المفضلة", ""),
                                  style: headingStyle.copyWith(
                                    color: kMainColor,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )
                : loading();
          },
        ),
      ),
    );
  }
}
