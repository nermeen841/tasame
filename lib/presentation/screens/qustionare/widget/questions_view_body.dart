// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/qustionare/cubit/quastionaire_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import '../../../../core/constants/constants.dart';

class QuestionViewBody extends StatefulWidget {
  final int quastionareId;

  const QuestionViewBody({Key? key, required this.quastionareId})
      : super(key: key);

  @override
  State<QuestionViewBody> createState() => _QuestionViewBodyState();
}

class _QuestionViewBodyState extends State<QuestionViewBody> {
  int? selected;
  int result = 0;
  int currentIndex = 0;
  List<String> answers = [];
  @override
  void initState() {
    answers.clear();
    result = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuastionaireCubit, QuastionaireState>(
      listener: (context, state) {},
      bloc: GetIt.I<QuastionaireCubit>(),
      builder: (context, state) {
        return (state is! GetQuestionsLoadingState)
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 0.04,
                  vertical: screenHeight(context) * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      GetIt.I<QuastionaireCubit>()
                          .questionsModel!
                          .data!
                          .questions![currentIndex]
                          .question!,
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth(context) * 0.045,
                        color: colorBlue,
                      ),
                    ),
                    const VerticalSpace(value: 2),
                    Column(
                      children: List.generate(
                        GetIt.I<QuastionaireCubit>()
                            .questionsModel!
                            .data!
                            .questions![currentIndex]
                            .answers!
                            .length,
                        (index) => Row(
                          children: [
                            Radio(
                                value: index,
                                activeColor: kMainColor,
                                groupValue: selected,
                                onChanged: (int? val) {
                                  setState(() {
                                    selected = val;
                                    answers.add(GetIt.I<QuastionaireCubit>()
                                        .questionsModel!
                                        .data!
                                        .questions![currentIndex]
                                        .answers![index]
                                        .index!);
                                  });
                                  if (currentIndex !=
                                      GetIt.I<QuastionaireCubit>()
                                              .questionsModel!
                                              .data!
                                              .questions!
                                              .length -
                                          1) {
                                    setState(() {
                                      currentIndex++;
                                      selected = null;
                                    });
                                  }
                                }),
                            const HorizontalSpace(value: 0.5),
                            Text(
                              GetIt.I<QuastionaireCubit>()
                                  .questionsModel!
                                  .data!
                                  .questions![currentIndex]
                                  .answers![index]
                                  .title!,
                              style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(context) * 0.04,
                                color: colordeepGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpace(value: 4),
                    (currentIndex ==
                            GetIt.I<QuastionaireCubit>()
                                    .questionsModel!
                                    .data!
                                    .questions!
                                    .length -
                                1)
                        ? SizedBox(
                            width: screenWidth(context) * 0.3,
                            child: CustomGeneralButton(
                              text: translateString(
                                  "Show result", "النتيجه", "Sonucu göster"),
                              textColor: Colors.white,
                              onTap: () {
                                getresult();
                                GetIt.I<QuastionaireCubit>()
                                    .getQuastionareResult(
                                        widget.quastionareId, result);
                                print(answers);
                                print(result);
                              },
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            : loading();
      },
    );
  }

/////////////////////////////////////////////////////////////////////
  getresult() {
    for (var element in answers) {
      if (element == "0") {
        setState(() {
          result += 4;
        });
      } else if (element == "1") {
        setState(() {
          result += 3;
        });
      } else if (element == "2") {
        setState(() {
          result += 2;
        });
      } else if (element == "3") {
        setState(() {
          result += 1;
        });
      } else {
        setState(() {
          result += 0;
        });
      }
    }
  }
}
