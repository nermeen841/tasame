// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/helper/validation.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/auth/forgetpassword/forget_password.dart';
import 'package:zat/presentation/screens/auth/login/widget/country_selection.dart';
import 'package:zat/presentation/screens/auth/register/register.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../dashboard/consultant/pages/upcomming_consultation/upcomming_consultation.dart';
import '../../bloc/Auth_cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode nameFocuse = FocusNode();
  FocusNode passwordFocuse = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
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
        padding: (prefs.getString("lang") != "ar")
            ? EdgeInsets.symmetric(
                horizontal: screenWidth(context) * 0.02,
                vertical: screenHeight(context) * 0.07,
              )
            : EdgeInsets.only(
                left: screenWidth(context) * 0.02,
                right: screenWidth(context) * 0.015,
                top: screenHeight(context) * 0.07,
                bottom: screenHeight(context) * 0.07,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalSpace(value: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.NOT_HAVE_ACCOUNT.tr(),
                  style: headingStyle.copyWith(
                    fontSize: screenWidth(context) * 0.03,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                InkWell(
                  onTap: () {
                    MagicRouter.navigateTo(const RegisterScreen());
                  },
                  child: Text(
                    " ${LocaleKeys.JOIN.tr()} ",
                    style: headingStyle.copyWith(
                      fontSize: screenWidth(context) * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpace(value: 3),
            Text(
              LocaleKeys.WELCOME_MESSAGE.tr(),
              textAlign: TextAlign.start,
              style: headingStyle.copyWith(
                fontSize: screenWidth(context) * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const VerticalSpace(value: 3),
            Text(
              LocaleKeys.PHONE.tr(),
              textAlign: TextAlign.start,
              style: headingStyle.copyWith(
                fontSize: screenWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
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
                    focusNode: nameFocuse,
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
                    onEditingComplete: () {
                      nameFocuse.unfocus();
                      FocusScope.of(context).requestFocus(passwordFocuse);
                    },
                  ),
                ),
                const HorizontalSpace(value: 0.2),
                Expanded(
                  child: CountrySelectionDropDown(
                    text: (countryName != null)
                        ? countryName!
                        : (prefs.getString("country_name") != null)
                            ? prefs.getString("country_name")!
                            : LocaleKeys.COUNTRY.tr(),
                  ),
                ),
              ],
            ),
            const VerticalSpace(value: 3),
            Text(
              LocaleKeys.PASSWORD.tr(),
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
              controller: password,
              focusNode: passwordFocuse,
              inputType: TextInputType.text,
              isPassword: showPassword,
              suffix: (showPassword)
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              suffixPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              validator: (value) => validatePassword(value!),
              onEditingComplete: () {
                passwordFocuse.unfocus();
              },
            ),
            const VerticalSpace(value: 2),
            InkWell(
              onTap: () {
                MagicRouter.navigateTo(const ForgetPasswordScreen());
              },
              child: Text(
                LocaleKeys.FORGET_PASSWORD.tr(),
                style: headingStyle.copyWith(
                  color: Colors.black,
                  fontSize: screenWidth(context) * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VerticalSpace(value: 2),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  GetIt.I<ProfileCubit>().getUserProfile();
                  GetIt.I<AuthCubit>().getcurrency();
                  if (prefs.getString("user_type") == "user") {
                    MagicRouter.navigateAndPopAll(const LayoutScreen(index: 4));
                    // MagicRouter.navigateAndPopAll(UpcommingConsultationsScreen(
                    //     fromAuth: true,
                    //     title: translateString("Upcomming Consultations",
                    //         "الاستشارات القادمة", "Yaklaşan İstişareler")));
                  } else {
                    MagicRouter.navigateAndPopAll(UpcommingConsultationTutor(
                        fromAuth: true,
                        title: translateString("Upcomming Consultations",
                            "الاستشارات القادمة", "Yaklaşan İstişareler")));
                  }
                  // MagicRouter.navigateTo(const CodeScreen(
                  //   fromLogin: true,
                  // ));
                }
              },
              bloc: GetIt.I<AuthCubit>(),
              builder: (context, state) {
                return (state is! LoginLoadingState)
                    ? CustomGeneralButton(
                        text: LocaleKeys.LOGIN_BUTTON.tr(),
                        color: colorBetrolly,
                        textColor: Colors.white,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (prefs.getString("country_code") != null) {
                              GetIt.I<AuthCubit>().postLogin(
                                phone: email.text,
                                password: password.text,
                              );
                            } else {
                              showToast(
                                msg: translateString("you must select country",
                                    "يجب اختيار الدولة", "ülke seçmelisiniz"),
                                state: ToastStates.ERROR,
                              );
                            }
                          }
                        },
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
