// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import 'person_card.dart';

class ConultantList extends StatefulWidget {
  const ConultantList({Key? key}) : super(key: key);

  @override
  State<ConultantList> createState() => _ConultantListState();
}

class _ConultantListState extends State<ConultantList> {
  @override
  void initState() {
    GetIt.I<HomeCubit>().getAllConsultant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return (GetIt.I<HomeCubit>().allConsultantModel == null)
            ? loading()
            : (GetIt.I<HomeCubit>().allConsultantModel!.data!.isNotEmpty)
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
                          .rate!
                          .toString(),
                      fromfavourite: GetIt.I<HomeCubit>()
                              .allConsultantModel!
                              .data![index]
                              .isFav ??
                          false,
                      lang: GetIt.I<HomeCubit>()
                          .allConsultantModel!
                          .data![index]
                          .languages!,
                    ),
                    itemCount:
                        GetIt.I<HomeCubit>().allConsultantModel!.data!.length,
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
