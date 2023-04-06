// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../cubit/home_cubit.dart';

bool isSearching = false;
String keyword = "";

class FilterSearchHome extends StatefulWidget {
  const FilterSearchHome({Key? key}) : super(key: key);

  @override
  State<FilterSearchHome> createState() => _FilterSearchHomeState();
}

class _FilterSearchHomeState extends State<FilterSearchHome> {
  List<Map<String, dynamic>> languages = [];
  List<Map<String, dynamic>> specialicty = [];
  String? selectedspecialicity;
  @override
  void initState() {
    gender = null;
    rateApi = null;
    rate = null;
    languageID = null;
    selectedLanguage = null;
    selectedCountry = null;
    selectedspecialicity = null;
    specialicityId = null;
    specialicty.clear();
    languages.clear();
    GetIt.I<HomeCubit>().getLanguage().then((value) {
      if (GetIt.I<HomeCubit>().languageModel != null) {
        languages.add({
          "name": translateString("All", "الكل", ""),
          "icon": "",
          "id": 0,
        });
        for (var element in GetIt.I<HomeCubit>().languageModel!.data!) {
          setState(() {
            languages.add({
              "name": element.name ?? "",
              "icon": element.icon ?? "",
              "id": element.id!,
            });
          });
        }
      }
    });
    GetIt.I<ProfileCubit>().getSpecialicity().then(
      (value) {
        if (GetIt.I<ProfileCubit>().specialicityModel != null) {
          specialicty.add({
            "name": translateString("All", "الكل", ""),
            "id": 0,
          });
          for (var element
              in GetIt.I<ProfileCubit>().specialicityModel!.data!) {
            setState(() {
              specialicty.add({
                "name": element.title ?? "",
                "id": element.id!,
              });
            });
          }
        }
      },
    );
    super.initState();
  }

  int? gender;
  int? specialicityId;
  String? date;
  int? rateApi;
  dynamic rate;
  int? languageID;
  String? selectedLanguage;
  String? selectedCountry;
  List<dynamic> rateValue = [translateString("All", "الكل", ''), 1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async => await selectDate(context).then(
                    (value) => GetIt.I<HomeCubit>().getSearchResult(
                      keyword: keyword,
                      gender: gender ?? 0,
                      languageID: languageID ?? 0,
                      rate: rateApi ?? 0,
                      specialictyId: specialicityId ?? 0,
                      date: date ?? "",
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: screenHeight(context) * 0.05,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth(context) * 0.01),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(screenWidth(context) * 0.015),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: colorGrey.withOpacity(0.2),
                          offset: const Offset(0, 1),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          date ??
                              translateString(
                                  "Available date", "التاريخ المناسب", ""),
                          style: headingStyle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down,
                            color: Colors.black87),
                      ],
                    ),
                  ),
                ),
                const VerticalSpace(value: 1),
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * 0.05,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(screenWidth(context) * 0.015),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: colorGrey.withOpacity(0.2),
                        offset: const Offset(0, 1),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {},
                    bloc: GetIt.I<HomeCubit>(),
                    builder: (context, state) {
                      return PopupMenuButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedLanguage ?? LocaleKeys.LANGUAGE.tr(),
                              style: headingStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down,
                                color: Colors.black87),
                          ],
                        ),
                        onSelected: (int? value) {
                          setState(() {
                            languageID = languages[value!]['id'];
                            isSearching = true;
                            selectedLanguage = languages[value]['name'];
                          });
                          GetIt.I<HomeCubit>().getSearchResult(
                            keyword: keyword,
                            gender: gender ?? 0,
                            rate: rateApi ?? 0,
                            specialictyId: specialicityId ?? 0,
                            date: date ?? "",
                            languageID: (selectedLanguage == "All" ||
                                    selectedLanguage == "الكل")
                                ? 0
                                : languages[value!]['id'],
                          );
                        },
                        itemBuilder: (context) => List.generate(
                          languages.length,
                          (index) => PopupMenuItem(
                            value: index,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (index != 0)
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            languages[index]['icon'] ?? ""),
                                        radius: screenWidth(context) * 0.03,
                                        backgroundColor: Colors.white,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: const AssetImage(
                                            "asset/icons/app_logo.png"),
                                        radius: screenWidth(context) * 0.03,
                                        backgroundColor: Colors.white,
                                      ),
                                const HorizontalSpace(value: 0.7),
                                Text(
                                  languages[index]['name'],
                                  style: headingStyle.copyWith(
                                    color: colordeepGrey,
                                    fontSize: screenWidth(context) * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalSpace(value: 1),
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * 0.05,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(screenWidth(context) * 0.015),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: colorGrey.withOpacity(0.2),
                        offset: const Offset(0, 1),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {},
                    bloc: GetIt.I<ProfileCubit>(),
                    builder: (context, state) {
                      return PopupMenuButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedspecialicity ??
                                  translateString("Specialicty", "التخصص", ""),
                              style: headingStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down,
                                color: Colors.black87),
                          ],
                        ),
                        onSelected: (int? value) {
                          setState(() {
                            specialicityId = specialicty[value!]['id'];
                            isSearching = true;
                            selectedspecialicity = specialicty[value]['name'];
                          });
                          GetIt.I<HomeCubit>().getSearchResult(
                            keyword: keyword,
                            gender: gender ?? 0,
                            rate: rateApi ?? 0,
                            specialictyId: (selectedspecialicity == "All" ||
                                    selectedspecialicity == "الكل")
                                ? 0
                                : specialicty[value!]['id'],
                            date: date ?? "",
                            languageID: languageID ?? 0,
                          );
                        },
                        itemBuilder: (context) => List.generate(
                          specialicty.length,
                          (index) => PopupMenuItem(
                            value: index,
                            child: Text(
                              specialicty[index]['name'],
                              style: headingStyle.copyWith(
                                color: colordeepGrey,
                                fontSize: screenWidth(context) * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalSpace(value: 1),
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * 0.05,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(screenWidth(context) * 0.015),
                    color: Colors.white,
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
                    child: PopupMenuButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedCountry ?? LocaleKeys.GENDER.tr(),
                            style: headingStyle.copyWith(
                              color: colordeepGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down,
                              color: Colors.black87),
                        ],
                      ),
                      onSelected: (value) {
                        if (value == 1) {
                          setState(() {
                            gender = 0;
                            isSearching = true;
                            selectedCountry =
                                translateString("All", "الكل", "herşey");
                          });
                        } else if (value == 2) {
                          setState(() {
                            gender = 1;
                            isSearching = true;
                            selectedCountry = LocaleKeys.MALE.tr();
                          });
                        } else {
                          setState(() {
                            gender = 2;
                            isSearching = true;
                            selectedCountry = LocaleKeys.FEMALE.tr();
                          });
                        }
                        GetIt.I<HomeCubit>().getSearchResult(
                            keyword: keyword,
                            gender: gender ?? 0,
                            languageID: languageID ?? 0,
                            specialictyId: specialicityId ?? 0,
                            date: date ?? "",
                            rate: rateApi ?? 0);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            translateString("All", "الكل", "herşey"),
                            style: headingStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            LocaleKeys.MALE.tr(),
                            style: headingStyle.copyWith(
                              color: Colors.black,
                              fontSize: screenWidth(context) * 0.04,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text(
                            LocaleKeys.FEMALE.tr(),
                            style: headingStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpace(value: 1),
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * 0.05,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(screenWidth(context) * 0.015),
                    color: Colors.white,
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
                    child: PopupMenuButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (rate != null)
                              ? Text(
                                  rate.toString(),
                                  style: headingStyle.copyWith(
                                    color: colordeepGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Text(
                                  translateString("Rate", "التقييم", "Oran"),
                                  style: headingStyle.copyWith(
                                    color: colordeepGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          const Icon(Icons.arrow_drop_down,
                              color: Colors.black87),
                        ],
                      ),
                      onSelected: (value) {
                        if (value == "All" || value == "الكل") {
                          setState(() {
                            rate = value;
                            rateApi = 0;
                          });
                        } else {
                          setState(() {
                            rate = value;
                            rateApi = int.parse(value.toString());
                          });
                        }

                        GetIt.I<HomeCubit>().getSearchResult(
                          keyword: keyword,
                          gender: gender ?? 0,
                          languageID: languageID ?? 0,
                          specialictyId: specialicityId ?? 0,
                          date: date ?? '',
                          rate: rateApi ?? 0,
                        );
                      },
                      itemBuilder: (context) => List.generate(
                        rateValue.length,
                        (index) => PopupMenuItem(
                          value: rateValue[index],
                          child: Text(
                            rateValue[index].toString(),
                            style: headingStyle.copyWith(
                              color: Colors.black,
                              fontSize: screenWidth(context) * 0.04,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpace(value: 2),
            SizedBox(
              width: double.infinity,
              height: screenHeight(context) * 0.065,
              child: Center(
                child: CustomTextFormField(
                  hint: LocaleKeys.SEARCH.tr(),
                  inputType: TextInputType.text,
                  prefix: Icon(
                    CupertinoIcons.search,
                    color: colorGrey,
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        isSearching = true;
                      });
                      GetIt.I<HomeCubit>().getSearchResult(
                        keyword: value,
                        gender: gender ?? 0,
                        languageID: languageID ?? 0,
                        rate: rateApi ?? 0,
                        specialictyId: specialicityId ?? 0,
                        date: date ?? "",
                      );
                    } else {
                      setState(() {
                        isSearching = false;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ////////////////////////////////////////////////////////////////////////
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1880, 8),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
