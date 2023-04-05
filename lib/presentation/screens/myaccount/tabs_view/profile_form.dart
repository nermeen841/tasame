import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/validation.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/custom_drop_down.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/auth/bloc/Auth_cubit/auth_cubit.dart';
import 'package:zat/presentation/screens/auth/login/widget/country_selection.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/myaccount/myaccount.dart';
import 'package:zat/presentation/screens/myaccount/widget/language_selection.dart';
import 'package:zat/presentation/screens/myaccount/widget/select_credits.dart';
import 'package:zat/presentation/screens/myaccount/widget/specialicity_selection.dart';
import 'package:zat/presentation/widget/profile_form_item.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController birthDatecontroller = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int? selected;

  List<String> selectionGender = [
    LocaleKeys.MALE.tr(),
    LocaleKeys.FEMALE.tr(),
  ];
  int? gender;

  @override
  void initState() {
    GetIt.I<ProfileCubit>().getUserProfile();
    if (GetIt.I<ProfileCubit>().userModel != null) {
      phone.text = GetIt.I<ProfileCubit>().userModel!.data!.mobile ?? "";
      name.text = GetIt.I<ProfileCubit>().userModel!.data!.name ?? "";
      email.text = GetIt.I<ProfileCubit>().userModel!.data!.email ?? "";
      birthDatecontroller.text =
          GetIt.I<ProfileCubit>().userModel!.data!.birthday ?? "";
    }
    LanguageSelection.languageApi.clear();
    SelectCreditsItem.creditsApi.clear();
    SpecialicitySelection.specialicityApi.clear();
    chosenValue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          GetIt.I<ProfileCubit>().getUserProfile();
          MagicRouter.navigateAndPReplacement(const MyProfileScreen());
        }
      },
      bloc: GetIt.I<ProfileCubit>(),
      builder: (context, state) {
        return (GetIt.I<ProfileCubit>().userModel != null)
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context) * 0.02,
                  horizontal: screenWidth(context) * 0.04,
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: LocaleKeys.GENDER.tr(),
                                style: headingStyle.copyWith(
                                  color: colordeepGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth(context) * 0.03,
                                )),
                            TextSpan(
                                text: "* ",
                                style: headingStyle.copyWith(
                                  color: kMainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth(context) * 0.03,
                                )),
                          ],
                        ),
                      ),
                      const VerticalSpace(value: 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          selectionGender.length,
                          (index) => SizedBox(
                            width: screenWidth(context) * 0.4,
                            child: RadioListTile(
                              value: index,
                              title: Text(
                                selectionGender[index],
                                style: headingStyle.copyWith(
                                  color: Colors.black87,
                                  fontSize: screenWidth(context) * 0.035,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              activeColor: colorBetrolly,
                              groupValue: (selected != null)
                                  ? selected
                                  : (GetIt.I<ProfileCubit>()
                                              .userModel!
                                              .data!
                                              .gender ==
                                          "1")
                                      ? 0
                                      : (GetIt.I<ProfileCubit>()
                                                  .userModel!
                                                  .data!
                                                  .gender ==
                                              "2")
                                          ? 1
                                          : selected,
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
                      ProfileFormItem(
                        title: LocaleKeys.NAME.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: name,
                          inputType: TextInputType.name,
                          validator: (value) => validateName(value!),
                          hint: GetIt.I<ProfileCubit>().userModel!.data!.name!,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.EMAIL.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: email,
                          inputType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value!),
                          hint: "",
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.PHONE.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: phone,
                          inputType: TextInputType.phone,
                          validator: (value) => validate(value!),
                          hint: "",
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.COUNTRY.tr(),
                        isRequired: false,
                        widget: CountrySelectionDropDown(
                          text: prefs.getString('country_name') ??
                              LocaleKeys.COUNTRY.tr(),
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.BIRTH_DATE.tr(),
                        isRequired: false,
                        widget: CustomTextFormField(
                          controller: birthDatecontroller,
                          hint: "",
                          inputType: TextInputType.text,
                          readOnly: true,
                          ontap: () => selectDate(context),
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.PASSWORD.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: password,
                          inputType: TextInputType.text,
                          isPassword: true,
                          validator: (value) => validatePassword(value!),
                          hint: "",
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.VERIFY_PASSWORD.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: confirmpassword,
                          isPassword: true,
                          inputType: TextInputType.text,
                          validator: (value) =>
                              validateConfirmPassword(value!, password.text),
                          hint: "",
                        ),
                      ),
                      const VerticalSpace(value: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          (state is! UpdateProfileTutorLoadingState)
                              ? SizedBox(
                                  width: screenWidth(context) * 0.25,
                                  height: screenHeight(context) * 0.04,
                                  child: CustomGeneralButton(
                                    text: LocaleKeys.UPDATE.tr(),
                                    textColor: Colors.white,
                                    onTap: () async {
                                      GetIt.I<ProfileCubit>()
                                          .postEditUserProfile(
                                        name: name.text,
                                        password: password.text,
                                        phone: phone.text,
                                        gender: (gender != null)
                                            ? gender!
                                            : int.parse(GetIt.I<ProfileCubit>()
                                                .userModel!
                                                .data!
                                                .gender!),
                                        birthdate: birthDatecontroller.text,
                                        email: email.text,
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: kMainColor,
                                  ),
                                ),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {},
                            bloc: GetIt.I<AuthCubit>(),
                            builder: (context, state) {
                              return TextButton(
                                  onPressed: () =>
                                      GetIt.I<AuthCubit>().postDeleteAccount(),
                                  child: Text(
                                    LocaleKeys.DELETE_ACCOUNT.tr(),
                                    style: headingStyle.copyWith(
                                      color: kMainColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : loading();
      },
    );
  }

  ///////////////////////////////////////////////////////
  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1880, 8),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDatecontroller.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
