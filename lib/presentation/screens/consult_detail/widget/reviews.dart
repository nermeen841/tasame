import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/helper/validation.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../home/cubit/home_cubit.dart';
import '../../messages/cubit/chat_cubit.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  TextEditingController comment = TextEditingController();
  bool addratting = false;
  double ratting = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.REVIEWS.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.06,
                color: colorBlue,
              ),
            ),
            const VerticalSpace(value: 2),
            (GetIt.I<HomeCubit>()
                    .consultantDetailModel!
                    .data!
                    .comments!
                    .isNotEmpty)
                ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) => Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context) * 0.02,
                            vertical: screenHeight(context) * 0.01,
                          ),
                          color: colorGrey.withOpacity(0.2),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: screenWidth(context) * 0.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      GetIt.I<HomeCubit>()
                                          .consultantDetailModel!
                                          .data!
                                          .comments![index]
                                          .user!,
                                      style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              screenWidth(context) * 0.04),
                                    ),
                                    Text(
                                      GetIt.I<HomeCubit>()
                                          .consultantDetailModel!
                                          .data!
                                          .comments![index]
                                          .date!,
                                      style: headingStyle.copyWith(
                                        color: colorGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: screenWidth(context) * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalSpace(value: 1),
                                Divider(
                                  color: colorGrey,
                                ),
                                const VerticalSpace(value: 1),
                                SizedBox(
                                  width: screenWidth(context) * 0.7,
                                  child: Text(
                                    GetIt.I<HomeCubit>()
                                        .consultantDetailModel!
                                        .data!
                                        .comments![index]
                                        .comment!,
                                    style: headingStyle.copyWith(
                                      color: colordeepGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: screenWidth(context) * 0.035,
                                    ),
                                  ),
                                ),
                                const VerticalSpace(value: 1),
                                Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: RatingBar(
                                    ignoreGestures: true,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      half: const Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                      ),
                                      empty: const Icon(
                                        Icons.star_outline,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    initialRating: double.parse(
                                        GetIt.I<HomeCubit>()
                                            .consultantDetailModel!
                                            .data!
                                            .comments![index]
                                            .rate!
                                            .toString()),
                                    itemCount: 5,
                                    itemSize: screenWidth(context) * 0.03,
                                    onRatingUpdate: (double value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: screenWidth(context) * 0.05,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  const AssetImage("asset/icons/logo.png"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) =>
                        const VerticalSpace(value: 2),
                    itemCount: GetIt.I<HomeCubit>()
                        .consultantDetailModel!
                        .data!
                        .comments!
                        .length,
                  )
                : const SizedBox(),
            const VerticalSpace(value: 2),
            (prefs.getString("user_type") == "user" && !addratting)
                ? Center(
                    child: SizedBox(
                      height: screenHeight(context) * 0.05,
                      width: screenWidth(context) * 0.4,
                      child: CustomGeneralButton(
                        text: translateString(
                            "Add comment", "اضف تعليق", "Yorum ekle"),
                        color: Colors.white,
                        borderColor: colordeepGrey,
                        textColor: colordeepGrey,
                        onTap: () {
                          setState(() {
                            addratting = true;
                          });
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
            (addratting)
                ? Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              addratting = false;
                            });
                          },
                          child: Text(
                            translateString("Close", "اغلاق", "kapat"),
                            style: headingStyle.copyWith(
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth(context) * 0.045,
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpace(value: 1),
                      Column(
                        children: [
                          RatingBar(
                            allowHalfRating: false,
                            onRatingUpdate: (value) {
                              setState(() {
                                ratting = value;
                              });
                            },
                            itemCount: 5,
                            initialRating: ratting,
                            itemSize: 40.0,
                            unratedColor: Colors.amber,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                              empty: const Icon(
                                Icons.star_outline,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          const VerticalSpace(value: 2),
                          CustomTextFormField(
                            hint: translateString(
                                "Add comment", "اضف تعليق", "Yorum ekle"),
                            controller: comment,
                            validator: (value) => validate(value!),
                          ),
                          const VerticalSpace(value: 4),
                          BlocConsumer<ChatCubit, ChatState>(
                            listener: (context, state) {},
                            bloc: GetIt.I<ChatCubit>(),
                            builder: (context, state) {
                              return CustomGeneralButton(
                                text: LocaleKeys.SEND.tr(),
                                borderColor: kMainColor,
                                textColor: kMainColor,
                                color: Colors.white,
                                onTap: () {
                                  setState(() {
                                    addratting = false;
                                  });
                                  GetIt.I<ChatCubit>().postAddRate(
                                    tutorId: GetIt.I<HomeCubit>()
                                        .consultantDetailModel!
                                        .data!
                                        .id!,
                                    rate: ratting,
                                    comment: comment.text,
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
