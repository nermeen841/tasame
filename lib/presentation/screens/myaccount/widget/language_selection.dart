// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/space_widget.dart';
import '../cubit/profile_cubit.dart';

Map<int, String> selectionRatting = {};

class LanguageSelection extends StatefulWidget {
  static List<int> languageApi = [];
  static List<int> rateApi = [];
  final List<String> languages;
  final Map<String, int> languageId;
  const LanguageSelection(
      {super.key, required this.languages, required this.languageId});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  List<bool> selectedLanguage = [];

  List<String> rates = ["1", "2", "3", "4", "5"];
  @override
  void initState() {
    selectionRatting.clear();
    LanguageSelection.languageApi.clear();
    selectedLanguage.clear();
    if (GetIt.I<HomeCubit>().languageModel != null &&
        GetIt.I<HomeCubit>().languageModel!.data!.isNotEmpty) {
      selectedLanguage = List<bool>.generate(
          GetIt.I<HomeCubit>().languageModel!.data!.length, (index) {
        if (widget.languages.isNotEmpty) {
          if (widget.languages.contains(
              GetIt.I<HomeCubit>().languageModel!.data![index].name)) {
            setState(() {
              selectedLanguage.add(true);

              LanguageSelection.languageApi
                  .add(GetIt.I<HomeCubit>().languageModel!.data![index].id!);
            });
            return true;
          } else {
            setState(() {
              selectedLanguage.add(false);
              LanguageSelection.languageApi
                  .remove(GetIt.I<HomeCubit>().languageModel!.data![index].id!);
            });
            return false;
          }
        } else {
          selectedLanguage.add(false);
          LanguageSelection.languageApi.clear();
          return false;
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: translateString(
                      "select language", "اختر اللغة", "Dil Seçin"),
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
        BlocConsumer<HomeCubit, HomeState>(
          bloc: GetIt.I<HomeCubit>(),
          listener: (context, state) {},
          builder: (context, state) =>
              (GetIt.I<HomeCubit>().languageModel != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        GetIt.I<HomeCubit>().languageModel!.data!.length,
                        (index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: (selectedLanguage.isNotEmpty)
                                      ? selectedLanguage[index]
                                      : false,
                                  onChanged: (value) {
                                    if (widget.languageId.isNotEmpty) {
                                      GetIt.I<ProfileCubit>().deleteLanguage(
                                          widget.languageId[GetIt.I<HomeCubit>()
                                                  .languageModel!
                                                  .data![index]
                                                  .name!] ??
                                              0);
                                    }
                                    setState(() {
                                      selectedLanguage[index] = value!;
                                    });
                                    if (LanguageSelection.languageApi.contains(
                                        GetIt.I<HomeCubit>()
                                            .languageModel!
                                            .data![index]
                                            .id!)) {
                                      setState(() {
                                        LanguageSelection.languageApi.remove(
                                            GetIt.I<HomeCubit>()
                                                .languageModel!
                                                .data![index]
                                                .id!);
                                      });
                                    } else {
                                      setState(() {
                                        LanguageSelection.languageApi.add(
                                            GetIt.I<HomeCubit>()
                                                .languageModel!
                                                .data![index]
                                                .id!);
                                      });
                                    }
                                  },
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      GetIt.I<HomeCubit>()
                                          .languageModel!
                                          .data![index]
                                          .icon!),
                                  radius: screenWidth(context) * 0.025,
                                  backgroundColor: Colors.white,
                                ),
                                const HorizontalSpace(value: 0.7),
                                Text(
                                  GetIt.I<HomeCubit>()
                                          .languageModel!
                                          .data![index]
                                          .name ??
                                      "",
                                  style: headingStyle.copyWith(
                                    color: colordeepGrey,
                                    fontSize: screenWidth(context) * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight(context) * 0.01),
                              child: SizedBox(
                                width: screenWidth(context) * 0.35,
                                child: LanguageRatting(
                                  items: rates,
                                  index: index,
                                  text: translateString(
                                      "Language rate", "التقييم", ""),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
        ),
        const VerticalSpace(value: 1),
        Text(
          translateString(
              "* to update language must select rate for each language",
              "* يجب تحديد تقييم لكل لغة يتم اختيارها لتحديث اللغة",
              ""),
          style: headingStyle.copyWith(
            color: kMainColor,
            fontSize: screenWidth(context) * 0.03,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////

}

// String? languageRatting;

class LanguageRatting extends StatefulWidget {
  const LanguageRatting({
    Key? key,
    this.items,
    this.text = '',
    this.fillColor = Colors.white,
    this.borderColor,
    required this.index,
  }) : super(key: key);
  final List<String>? items;
  final String text;
  final int index;
  final Color? fillColor;
  final Color? borderColor;

  @override
  _LanguageRattingState createState() => _LanguageRattingState();
}

class _LanguageRattingState extends State<LanguageRatting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: (widget.borderColor == null)
            ? Border.all(color: colorGrey.withOpacity(0.2))
            : Border.all(color: widget.borderColor!),
        color: widget.fillColor!,
      ),
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: DropdownButtonFormField(
        isDense: true,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: colorGrey,
          size: 30,
        ),
        iconEnabledColor: const Color.fromRGBO(148, 148, 148, 1),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        value: selectionRatting[widget.index],
        items: widget.items?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: headingStyle.copyWith(color: colordeepGrey, fontSize: 12),
            ),
          );
        }).toList(),
        hint: Text(
          widget.text,
          style: headingStyle.copyWith(
              color: colorGrey, fontSize: screenWidth(context) * 0.03),
        ),
        onChanged: (String? value) {
          setState(() {
            selectionRatting[widget.index] = value!;
            LanguageSelection.rateApi.add(int.parse(value.toString()));
          });
        },
      ),
    );
  }
}
