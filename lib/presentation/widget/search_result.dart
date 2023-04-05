import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';

import '../../core/constants/constants.dart';
import '../screens/home/cubit/home_cubit.dart';
import 'person_card.dart';

class SearchResultData extends StatefulWidget {
  const SearchResultData({Key? key}) : super(key: key);

  @override
  State<SearchResultData> createState() => _SearchResultDataState();
}

class _SearchResultDataState extends State<SearchResultData> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return (state is! GetSearchResultLoadingState)
            ? GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) =>
                    (GetIt.I<HomeCubit>().allConsultantModel!.data!.isNotEmpty)
                        ? PersonCard(
                            counsultantID: GetIt.I<HomeCubit>()
                                .allConsultantModel!
                                .data![index]
                                .id!,
                            name: GetIt.I<HomeCubit>()
                                .allConsultantModel!
                                .data![index]
                                .name!,
                            image: GetIt.I<HomeCubit>()
                                .allConsultantModel!
                                .data![index]
                                .image!,
                            rate: GetIt.I<HomeCubit>()
                                    .allConsultantModel!
                                    .data![index]
                                    .rate ??
                                "",
                            fromfavourite: GetIt.I<HomeCubit>()
                                    .allConsultantModel!
                                    .data![index]
                                    .isFav ??
                                false,
                            lang: GetIt.I<HomeCubit>()
                                .allConsultantModel!
                                .data![index]
                                .languages!,
                          )
                        : Center(
                            child: Text(
                              translateString(
                                  "no result found", "لا توجد نتائج للبحث", ""),
                              style: headingStyle.copyWith(
                                color: kMainColor,
                              ),
                            ),
                          ),
                itemCount:
                    GetIt.I<HomeCubit>().allConsultantModel!.data!.length,
              )
            : loading();
      },
    );
  }
}
