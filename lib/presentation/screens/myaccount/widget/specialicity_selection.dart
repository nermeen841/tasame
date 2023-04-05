// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';

class SpecialicitySelection extends StatefulWidget {
  static List<int> specialicityApi = [];
  final List<String> specialicities;
  final Map<String, int> specialicitiesId;
  const SpecialicitySelection({
    super.key,
    required this.specialicities,
    required this.specialicitiesId,
  });

  @override
  State<SpecialicitySelection> createState() => _SpecialicitySelectionState();
}

class _SpecialicitySelectionState extends State<SpecialicitySelection> {
  List<bool> selectedSpecialicity = [];

  @override
  void initState() {
    print(widget.specialicitiesId);
    selectedSpecialicity.clear();
    GetIt.I<ProfileCubit>().getSpecialicity().then((value) {
      if (GetIt.I<ProfileCubit>().specialicityModel != null &&
          GetIt.I<ProfileCubit>().specialicityModel!.data!.isNotEmpty) {
        selectedSpecialicity = List<bool>.generate(
            GetIt.I<ProfileCubit>().specialicityModel!.data!.length, (index) {
          if (widget.specialicities.isNotEmpty) {
            if (widget.specialicities.contains(GetIt.I<ProfileCubit>()
                .specialicityModel!
                .data![index]
                .title)) {
              selectedSpecialicity.add(true);

              SpecialicitySelection.specialicityApi.add(
                  GetIt.I<ProfileCubit>().specialicityModel!.data![index].id!);
              return true;
            } else {
              selectedSpecialicity.add(false);
              SpecialicitySelection.specialicityApi.remove(
                  GetIt.I<ProfileCubit>().specialicityModel!.data![index].id!);
              return false;
            }
          } else {
            selectedSpecialicity.add(false);
            SpecialicitySelection.specialicityApi.clear();
            return false;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: GetIt.I<ProfileCubit>(),
      listener: (context, state) {},
      builder: (context, state) => (GetIt.I<ProfileCubit>().specialicityModel !=
              null)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: translateString("select specialicity",
                              "اختر التخصص", "uzmanlık seç"),
                          style: headingStyle.copyWith(
                            color: colordeepGrey,
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth(context) * 0.03,
                          )),
                      TextSpan(
                          text: "*",
                          style: headingStyle.copyWith(
                            color: kMainColor,
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth(context) * 0.03,
                          )),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    GetIt.I<ProfileCubit>().specialicityModel!.data!.length,
                    (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: (selectedSpecialicity.isNotEmpty)
                                  ? selectedSpecialicity[index]
                                  : false,
                              onChanged: (value) {
                                if (widget.specialicitiesId.isNotEmpty) {
                                  GetIt.I<ProfileCubit>().deleteSpecialicity(
                                      widget.specialicitiesId[
                                              GetIt.I<ProfileCubit>()
                                                  .specialicityModel!
                                                  .data![index]
                                                  .title!] ??
                                          0);
                                }
                                setState(() {
                                  selectedSpecialicity[index] = value!;
                                });

                                if (!SpecialicitySelection.specialicityApi
                                    .contains(GetIt.I<ProfileCubit>()
                                        .specialicityModel!
                                        .data![index]
                                        .id!)) {
                                  SpecialicitySelection.specialicityApi.add(
                                      GetIt.I<ProfileCubit>()
                                          .specialicityModel!
                                          .data![index]
                                          .id!);
                                } else {
                                  SpecialicitySelection.specialicityApi.remove(
                                      GetIt.I<ProfileCubit>()
                                          .specialicityModel!
                                          .data![index]
                                          .id!);
                                }
                                print(SpecialicitySelection.specialicityApi);
                              },
                            ),
                            Text(
                              GetIt.I<ProfileCubit>()
                                      .specialicityModel!
                                      .data![index]
                                      .title ??
                                  "",
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
              ],
            )
          : Center(
              child: LinearProgressIndicator(
                color: kMainColor,
              ),
            ),
    );
  }
}
