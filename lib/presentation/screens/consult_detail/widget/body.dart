import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/consult_detail/widget/offers.dart';
import 'reviews.dart';
import 'user_info.dart';

class ConsultantDetailBody extends StatefulWidget {
  const ConsultantDetailBody({Key? key}) : super(key: key);

  @override
  State<ConsultantDetailBody> createState() => _ConsultantDetailBodyState();
}

class _ConsultantDetailBodyState extends State<ConsultantDetailBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.04,
        vertical: screenHeight(context) * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.02,
              vertical: screenHeight(context) * 0.02,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth(context) * 0.02),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                ConsultantInfoCard(),
              ],
            ),
          ),
          const VerticalSpace(value: 2),
          const ConsultantOffers(),
          const VerticalSpace(value: 2),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.02,
              vertical: screenHeight(context) * 0.02,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth(context) * 0.02),
            ),
            child: const ReviewsView(),
          ),
        ],
      ),
    );
  }
}
