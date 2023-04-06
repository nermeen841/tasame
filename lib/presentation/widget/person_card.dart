import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/custom_buttons_widget.dart';
import '../../core/widgets/space_widget.dart';

class PersonCard extends StatefulWidget {
  final bool? fromfavourite;
  final int counsultantID;
  final String name;
  final dynamic image;
  final String rate;
  final List lang;
  const PersonCard(
      {Key? key,
      this.fromfavourite,
      required this.name,
      required this.image,
      required this.rate,
      required this.lang,
      required this.counsultantID})
      : super(key: key);

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.012,
        vertical: screenHeight(context) * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth(context) * 0.015),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: colorGrey.withOpacity(0.2),
            offset: const Offset(0, 2),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              GetIt.I<HomeCubit>()
                  .getConsultantDetail(widget.counsultantID, true);
            },
            child: SizedBox(
              width: double.infinity,
              height: screenHeight(context) * 0.21,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight(context) * 0.23,
                    child: customCachedNetworkImage(
                      url: widget.image,
                      context: context,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  (prefs.getString("user_type") == "user")
                      ? Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.01,
                              left: screenWidth(context) * 0.01,
                              right: screenWidth(context) * 0.01,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CircleAvatar(
                                //   radius: screenWidth(context) * 0.03,
                                //   backgroundImage: const NetworkImage(
                                //       "https://img.freepik.com/free-vector/retro-background-american-football-elements_23-2147596551.jpg?w=360&t=st=1671021354~exp=1671021954~hmac=2d2e5002e840d3f301d5b728ae081bd9c944f30c6fa48cf5b4f58fe780b8f53e"),
                                // ),
                                BlocConsumer<HomeCubit, HomeState>(
                                  listener: (context, state) {
                                    // if (state is AddRemoveFromFavouriteSuccessState) {
                                    //   GetIt.I<HomeCubit>().getFavouriteData();
                                    // }
                                  },
                                  bloc: GetIt.I<HomeCubit>(),
                                  builder: (context, state) {
                                    return InkWell(
                                      onTap: () {
                                        GetIt.I<HomeCubit>()
                                            .postAddRemoveFavourite(
                                                tutorID: widget.counsultantID);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white54,
                                        radius: screenWidth(context) * 0.04,
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: (GetIt.I<HomeCubit>()
                                                            .isFavourite[
                                                        widget.counsultantID] ==
                                                    true)
                                                ? kMainColor
                                                : kMainColor.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: (widget.lang.isNotEmpty)
                        ? Container(
                            height: screenHeight(context) * 0.04,
                            alignment: AlignmentDirectional.bottomStart,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight(context) * 0.003,
                              horizontal: screenWidth(context) * 0.01,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth(context) * 0.01,
                              vertical: screenHeight(context) * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(
                                screenWidth(context) * 0.015,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                  widget.lang.length,
                                  (index) => CircleAvatar(
                                        radius: screenWidth(context) * 0.035,
                                        backgroundImage: NetworkImage(
                                          widget.lang[index].icon.toString(),
                                        ),
                                      )),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          const VerticalSpace(value: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth(context) * 0.035,
                ),
              ),
            ],
          ),
          const VerticalSpace(value: 0.5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.amber,
                    size: screenWidth(context) * 0.03,
                  ),
                  Text(
                    widget.rate,
                    style: headingStyle.copyWith(
                      color: colordeepGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth(context) * 0.03,
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   width: screenWidth(context) * 0.2,
              //   height: screenHeight(context) * 0.033,
              //   child: CustomGeneralButton(
              //     text: LocaleKeys.BOOK.tr(),
              //     fontSize: screenWidth(context) * 0.03,
              //     textColor: Colors.white,
              //     onTap: () => GetIt.I<HomeCubit>()
              //         .getConsultantDetail(widget.counsultantID),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            // width: screenWidth(context) * 0.2,
            height: screenHeight(context) * 0.033,
            child: CustomGeneralButton(
              text: LocaleKeys.VIEW_PROFILE.tr(),
              fontSize: screenWidth(context) * 0.03,
              borderColor: kMainColor,
              textColor: colordeepGrey,
              color: Colors.white,
              onTap: () => GetIt.I<HomeCubit>()
                  .getConsultantDetail(widget.counsultantID, true),
            ),
          ),
        ],
      ),
    );
  }
}
