// ignore_for_file: deprecated_member_use, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/validation.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';

import 'contactinfo.dart';
import 'cubit/setting_cubit.dart';

class ContactusBody extends StatefulWidget {
  const ContactusBody({Key? key}) : super(key: key);

  @override
  State<ContactusBody> createState() => _ContactusBodyState();
}

class _ContactusBodyState extends State<ContactusBody> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();
  FocusNode nameFocuse = FocusNode();
  FocusNode emailFocuse = FocusNode();
  FocusNode phoneFocuse = FocusNode();
  FocusNode messageFocuse = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    GetIt.I<ProfileCubit>().getUserProfile();
    if (prefs.getString("user_type") == "user") {
      if (GetIt.I<ProfileCubit>().userModel != null) {
        name.text = GetIt.I<ProfileCubit>().userModel!.data!.name ?? "";
        email.text = GetIt.I<ProfileCubit>().userModel!.data!.email ?? "";
        phone.text = GetIt.I<ProfileCubit>().userModel!.data!.mobile ?? "";
      }
    } else {
      if (GetIt.I<ProfileCubit>().tutorProfileModel != null) {
        name.text = GetIt.I<ProfileCubit>().tutorProfileModel!.data!.name ?? "";
        email.text =
            GetIt.I<ProfileCubit>().tutorProfileModel!.data!.email ?? "";
        phone.text =
            GetIt.I<ProfileCubit>().tutorProfileModel!.data!.mobile ?? "";
      }
    }
    GetIt.I<SettingCubit>().getSettingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.04,
        vertical: screenHeight(context) * 0.02,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ContactusInfoItem(),
            const VerticalSpace(value: 5),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {},
              bloc: GetIt.I<ProfileCubit>(),
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.FULL_NAME.tr(),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colordeepGrey,
                      ),
                    ),
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
                    const VerticalSpace(value: 3),
                    Text(
                      LocaleKeys.EMAIL.tr(),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colordeepGrey,
                      ),
                    ),
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
                    const VerticalSpace(value: 3),
                    Text(
                      LocaleKeys.PHONE.tr(),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colordeepGrey,
                      ),
                    ),
                    CustomTextFormField(
                      hint: "",
                      controller: phone,
                      focusNode: phoneFocuse,
                      inputType: TextInputType.phone,
                      validator: (value) => validate(value!),
                      onEditingComplete: () {
                        phoneFocuse.unfocus();
                        FocusScope.of(context).requestFocus(messageFocuse);
                      },
                    ),
                    const VerticalSpace(value: 3),
                    Text(
                      translateString("Message", "الرسالة", "İleti"),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colordeepGrey,
                      ),
                    ),
                    CustomTextFormField(
                      hint: "",
                      controller: message,
                      focusNode: messageFocuse,
                      maxLines: 7,
                      inputType: TextInputType.text,
                      validator: (value) => validate(value!),
                      onEditingComplete: () {
                        messageFocuse.unfocus();
                      },
                    ),
                    const VerticalSpace(value: 4),
                  ],
                );
              },
            ),
            BlocConsumer<SettingCubit, SettingState>(
              listener: (context, state) {},
              bloc: GetIt.I<SettingCubit>(),
              builder: (context, state) {
                return CustomGeneralButton(
                  text: LocaleKeys.SEND.tr(),
                  textColor: Colors.white,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      GetIt.I<SettingCubit>().postContactUs(
                        name: name.text,
                        email: email.text,
                        phone: phone.text,
                        message: message.text,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
