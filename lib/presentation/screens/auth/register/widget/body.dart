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
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/auth/login/login.dart';
import 'package:zat/presentation/screens/auth/login/widget/country_selection.dart';
import 'package:zat/presentation/screens/info/info.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../contactus/cubit/setting_cubit.dart';
import '../../bloc/Auth_cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode nameFocuse = FocusNode();
  FocusNode emailFocuse = FocusNode();
  FocusNode phoneFocuse = FocusNode();
  FocusNode passwordFocuse = FocusNode();
  bool showPassword = true;
  final formKey = GlobalKey<FormState>();
  int? selectedValue;
  int? selected;
  List<String> selectionType = [
    LocaleKeys.STUDENT.tr(),
    LocaleKeys.CONSULTANT.tr(),
  ];
  List<String> selectionGender = [
    LocaleKeys.MALE.tr(),
    LocaleKeys.FEMALE.tr(),
  ];
  int? roleId;
  int? gender;
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
          horizontal: screenWidth(context) * 0.02,
          vertical: screenHeight(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.HAVE_ACCOUNT.tr(),
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorGrey,
                    ),
                  ),
                  const HorizontalSpace(value: 0.5),
                  InkWell(
                    onTap: () => MagicRouter.navigateTo(const LoginScreen()),
                    child: Text(
                      LocaleKeys.LOG.tr(),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpace(value: 4),
            Text(
              LocaleKeys.REGISTER_TITLE.tr(),
              style: headingStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth(context) * 0.05,
              ),
            ),
            const VerticalSpace(value: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                selectionType.length,
                (index) => SizedBox(
                  width: screenWidth(context) * 0.46,
                  child: RadioListTile(
                    value: index,
                    title: Text(
                      selectionType[index],
                      maxLines: 1,
                      style: headingStyle.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    activeColor: colorBetrolly,
                    groupValue: selectedValue,
                    onChanged: (int? value) {
                      setState(() {
                        selectedValue = value;
                      });
                      if (index == 0) {
                        setState(() {
                          roleId = 2;
                          prefs.setString("user_type", "user");
                        });
                      } else {
                        setState(() {
                          roleId = 3;
                          prefs.setString("user_type", "consultant");
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            const VerticalSpace(value: 2),
            Text(
              LocaleKeys.GENDER.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
            const VerticalSpace(value: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                selectionGender.length,
                (index) => SizedBox(
                  width: screenWidth(context) * 0.43,
                  child: RadioListTile(
                    value: index,
                    title: Text(
                      selectionGender[index],
                      style: headingStyle.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    activeColor: colorBetrolly,
                    groupValue: selected,
                    onChanged: (int? value) {
                      setState(() {
                        selected = value;
                      });
                      if (index == 0) {
                        setState(() {
                          gender = 1;
                        });
                      } else {
                        setState(() {
                          gender = 2;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            const VerticalSpace(value: 2),
            Text(
              LocaleKeys.FULL_NAME.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
            const VerticalSpace(value: 1),
            CustomTextFormField(
              hint: "",
              controller: name,
              focusNode: nameFocuse,
              inputType: TextInputType.name,
              validator: (value) => validateName(value!),
              onEditingComplete: () {
                nameFocuse.unfocus();
                FocusScope.of(context).requestFocus(emailFocuse);
              },
            ),
            const VerticalSpace(value: 2),
            Text(
              LocaleKeys.EMAIL.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
            const VerticalSpace(value: 1),
            CustomTextFormField(
              hint: "",
              controller: email,
              focusNode: emailFocuse,
              inputType: TextInputType.emailAddress,
              validator: (value) => validateEmail(value!),
              onEditingComplete: () {
                emailFocuse.unfocus();
                FocusScope.of(context).requestFocus(phoneFocuse);
              },
            ),
            const VerticalSpace(value: 2),
            Text(
              LocaleKeys.PHONE.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth(context) * 0.63,
                  child: CustomTextFormField(
                    hint: "",
                    controller: phone,
                    focusNode: phoneFocuse,
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
                      phoneFocuse.unfocus();
                      FocusScope.of(context).requestFocus(passwordFocuse);
                    },
                  ),
                ),
                const HorizontalSpace(value: 0.5),
                Expanded(
                  // width: screenWidth(context) * 0.37,
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
            const VerticalSpace(value: 2),
            Text(
              LocaleKeys.PASSWORD.tr(),
              style: headingStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: screenWidth(context) * 0.04,
              ),
            ),
            const VerticalSpace(value: 1),
            CustomTextFormField(
              hint: "",
              controller: password,
              focusNode: passwordFocuse,
              isPassword: showPassword,
              inputType: TextInputType.text,
              validator: (value) => validatePassword(value!),
              suffix: (showPassword)
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              suffixPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              onEditingComplete: () {
                passwordFocuse.unfocus();
              },
            ),
            const VerticalSpace(value: 2),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  MagicRouter.navigateAndPopAll(const LoginScreen());
                }
              },
              bloc: GetIt.I<AuthCubit>(),
              builder: (context, state) {
                return (state is! RegisterLoadingState)
                    ? CustomGeneralButton(
                        text: LocaleKeys.CREATE_ACCOUNT.tr(),
                        textColor: Colors.white,
                        onTap: () {
                          print(roleId);
                          if (formKey.currentState!.validate()) {
                            if (roleId != null || gender != null) {
                              if (prefs.getString("country_code") != null) {
                                GetIt.I<AuthCubit>().postRegister(
                                  mobile: phone.text,
                                  email: email.text,
                                  name: name.text,
                                  password: password.text,
                                  roleId: roleId!,
                                  gender: gender!,
                                );
                              } else {
                                showToast(
                                  msg: translateString(
                                      "you must select country",
                                      "يجب اختيار الدولة",
                                      "ülke seçmelisiniz"),
                                  state: ToastStates.ERROR,
                                );
                              }
                            } else {
                              showToast(
                                  msg: "please select your role and gender",
                                  state: ToastStates.ERROR);
                            }
                          }
                        },
                        color: colorBetrolly,
                      )
                    : loading();
              },
            ),
            const VerticalSpace(value: 2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    translateString(
                        "By creating an account, you agree to",
                        "بإنشاء حساب ، أنت توافق على",
                        "Hesap oluşturarak şunları kabul etmiş olursunuz"),
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorGrey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    GetIt.I<SettingCubit>().getCustomPage();
                    MagicRouter.navigateTo(
                      InfoScreen(
                        title: GetIt.I<SettingCubit>()
                            .customPagesModel!
                            .data![1]
                            .title!,
                        content: GetIt.I<SettingCubit>()
                            .customPagesModel!
                            .data![1]
                            .body!,
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      translateString(
                          "Terms of Service Privacy Cookies",
                          "ملفات تعريف الارتباط الخاصة بشروط الخدمة",
                          "Hizmet Koşulları Gizlilik Çerezleri"),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
