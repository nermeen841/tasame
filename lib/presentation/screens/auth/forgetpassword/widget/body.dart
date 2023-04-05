// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/auth/forgetpassword/code/code.dart';
import 'package:zat/presentation/screens/auth/login/widget/country_selection.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../bloc/Auth_cubit/auth_cubit.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? countryName;
  Future lookupUserCountry() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.country.is'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (GetIt.I<AuthCubit>().countryModel != null) {
          for (var element in GetIt.I<AuthCubit>().countryModel!.data!) {
            if (element.isoCode == data['country']) {
              setState(() {
                countryName = element.name ?? "";
                prefs.setString("country_code", element.code.toString());
                prefs.setInt("countryId", element.id!);
                prefs.setString("country_name", element.name!);
                prefs.setString("currency", element.currencyCode.toString());
                prefs.setString("phone_num", element.countNum.toString());
              });
            }
          }
        }
      }
    } catch (e) {
      print("error optain user country :  ${e.toString()}");
    }
  }

  @override
  void initState() {
    lookupUserCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.03,
          vertical: screenHeight(context) * 0.04,
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                LocaleKeys.RESET_PASSWORD.tr(),
                textAlign: TextAlign.start,
                style: headingStyle.copyWith(
                  fontSize: screenWidth(context) * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const VerticalSpace(value: 0.5),
            Center(
              child: Text(
                LocaleKeys.FORGET_MESSAGE.tr(),
                textAlign: TextAlign.center,
                style: headingStyle.copyWith(
                  fontSize: screenWidth(context) * 0.04,
                  fontWeight: FontWeight.w400,
                  color: colorBetrolly.withOpacity(0.3),
                ),
              ),
            ),
            const VerticalSpace(value: 8),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                LocaleKeys.PHONE.tr(),
                textAlign: TextAlign.start,
                style: headingStyle.copyWith(
                  fontSize: screenWidth(context) * 0.04,
                  fontWeight: FontWeight.w600,
                  color: kMainColor,
                ),
              ),
            ),
            const VerticalSpace(value: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth(context) * 0.63,
                  child: CustomTextFormField(
                    hint: "",
                    controller: email,
                    inputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translateString("This field is required",
                            "هذا الحقل مطلوب", "Bu alan gereklidir");
                      } else {
                        if (prefs.getString("phone_num") != null) {
                          if (value.length.toString() !=
                              prefs.getString("phone_num")!.toString()) {
                            return translateString(
                              "phone number must be ${prefs.getString("phone_num")!.toString()} digits",
                              "رقم الهاتف يجب ان يكون ${prefs.getString("phone_num")!.toString()} رقم",
                              "telefon numarası ${prefs.getString("phone_num")!.toString()} haneli olmalıdır",
                            );
                          } else {
                            return null;
                          }
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                ),
                const HorizontalSpace(value: 0.5),
                Expanded(
                  // width: screenWidth(context) * 0.3,
                  child: CountrySelectionDropDown(
                    text: (countryName != null)
                        ? countryName!
                        : prefs.getString("country_name") ??
                            LocaleKeys.COUNTRY.tr(),
                  ),
                ),
              ],
            ),
            const VerticalSpace(value: 4),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccessState) {
                  MagicRouter.navigateTo(const CodeScreen(
                    fromLogin: false,
                  ));
                }
              },
              bloc: GetIt.I<AuthCubit>(),
              builder: (context, state) {
                return (state is! ForgetPasswordLoadingState)
                    ? Center(
                        child: CustomGeneralButton(
                          text: LocaleKeys.SEND_LINK.tr(),
                          textColor: Colors.white,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              GetIt.I<AuthCubit>()
                                  .postForgetPassword(phone: email.text);
                            }
                          },
                          color: kMainColor,
                        ),
                      )
                    : loading();
              },
            ),
          ],
        ),
      ),
    );
  }
}
