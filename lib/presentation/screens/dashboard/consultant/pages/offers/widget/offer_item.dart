import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/widgets/space_widget.dart';

class OfferItem extends StatefulWidget {
  final String numOfConsultations;
  final String price;
  final int offerID;
  const OfferItem(
      {Key? key,
      required this.numOfConsultations,
      required this.price,
      required this.offerID})
      : super(key: key);

  @override
  State<OfferItem> createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight(context) * 0.02,
        horizontal: screenWidth(context) * 0.02,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${translateString("Num of consultant: ", "عدد الاستشارات", "danışman sayısı")} ",
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
              Text(
                widget.numOfConsultations,
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
            ],
          ),
          const VerticalSpace(value: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translateString("price: ", "السعر : ", "fiyat"),
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
              Text(
                widget.price,
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
            ],
          ),
          const VerticalSpace(value: 1),
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is DeleteOfferSuccessState) {
                GetIt.I<ProfileCubit>().getUserProfile();
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 3,
                ));
              }
            },
            bloc: GetIt.I<ProfileCubit>(),
            builder: (context, state) {
              return CustomGeneralButton(
                textColor: kMainColor,
                borderColor: kMainColor,
                color: Colors.white,
                text: translateString("Delete", "حذف", "silmek"),
                onTap: () =>
                    GetIt.I<ProfileCubit>().deleteOffer(widget.offerID),
              );
            },
          ),
          const VerticalSpace(value: 1),
        ],
      ),
    );
  }
}
