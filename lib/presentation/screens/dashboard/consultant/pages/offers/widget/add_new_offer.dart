import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/validation.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../../../../core/constants/colors.dart';

class CreateNewOffer extends StatefulWidget {
  const CreateNewOffer({Key? key}) : super(key: key);

  @override
  State<CreateNewOffer> createState() => _CreateNewOfferState();
}

class _CreateNewOfferState extends State<CreateNewOffer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController numofConsult = TextEditingController();
  TextEditingController price = TextEditingController();
  FocusNode numFocuse = FocusNode();
  FocusNode priceFocuse = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const VerticalSpace(value: 4),
          Text(
            "${translateString("Num of consultant ", "عدد الاستشارات", "danışman sayısı")} ",
            textAlign: TextAlign.start,
            style: headingStyle.copyWith(
              fontSize: screenWidth(context) * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const VerticalSpace(value: 1),
          CustomTextFormField(
            hint: "",
            controller: numofConsult,
            inputType: TextInputType.number,
            focusNode: numFocuse,
            validator: (value) => validate(value!),
            onEditingComplete: () {
              numFocuse.unfocus();
              FocusScope.of(context).requestFocus(priceFocuse);
            },
          ),
          const VerticalSpace(value: 2),
          Text(
            translateString("price", "السعر ", "fiyat"),
            textAlign: TextAlign.start,
            style: headingStyle.copyWith(
              fontSize: screenWidth(context) * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const VerticalSpace(value: 1),
          CustomTextFormField(
            hint: "",
            controller: price,
            inputType: TextInputType.number,
            focusNode: priceFocuse,
            validator: (value) => validate(value!),
            onEditingComplete: () {
              priceFocuse.unfocus();
            },
          ),
          const VerticalSpace(value: 4),
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is AddNewOfferErrorState ||
                  state is AddNewOfferSuccessState) {
                GetIt.I<ProfileCubit>().getUserProfile();
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 1,
                ));
                // MagicRouter.navigateAndPReplacement(const ManageOffersScreen());
              }
            },
            bloc: GetIt.I<ProfileCubit>(),
            builder: (context, state) {
              return (state is! AddNewOfferLoadingState)
                  ? CustomGeneralButton(
                      color: kMainColor,
                      textColor: Colors.white,
                      text: translateString("Create", "اضافة", "oluşturmak"),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          GetIt.I<ProfileCubit>().postAddNewOffer(
                              numofConsultant: numofConsult.text,
                              price: price.text);
                        }
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
