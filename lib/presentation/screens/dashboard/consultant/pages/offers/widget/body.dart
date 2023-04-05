import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'add_new_offer.dart';
import 'show_offers.dart';

bool createOffer = false;

class ManageOffersBody extends StatefulWidget {
  const ManageOffersBody({Key? key}) : super(key: key);

  @override
  State<ManageOffersBody> createState() => _ManageOffersBodyState();
}

class _ManageOffersBodyState extends State<ManageOffersBody> {
  @override
  void initState() {
    GetIt.I<ProfileCubit>().getUserProfile();
    createOffer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<ProfileCubit>().getUserProfile(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.02,
        ),
        child: (!createOffer)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomGeneralButton(
                    color: kMainColor,
                    textColor: Colors.white,
                    text: translateString("Add New package", "اضافة باقة جديدة",
                        "Yeni Teklif Oluştur"),
                    onTap: () {
                      setState(() {
                        createOffer = true;
                      });
                    },
                  ),
                  const VerticalSpace(value: 3),
                  const ShowTutorOffers(),
                ],
              )
            : const CreateNewOffer(),
      ),
    );
  }
}
