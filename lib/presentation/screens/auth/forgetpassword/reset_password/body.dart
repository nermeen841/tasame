import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/presentation/screens/auth/login/login.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/helper/validation.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../../../../generator/locale_keys.dart';
import '../../bloc/Auth_cubit/auth_cubit.dart';

class ResetPassowrdBody extends StatefulWidget {
  const ResetPassowrdBody({Key? key}) : super(key: key);

  @override
  State<ResetPassowrdBody> createState() => _ResetPassowrdBodyState();
}

class _ResetPassowrdBodyState extends State<ResetPassowrdBody> {
  TextEditingController password = TextEditingController();
  TextEditingController verifypassword = TextEditingController();
  FocusNode passwordFocuse = FocusNode();
  FocusNode verifypasswordFocuse = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool showPassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                LocaleKeys.RESET_PASSWORD.tr(),
                textAlign: TextAlign.start,
                style: headingStyle.copyWith(
                  fontSize: screenWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const VerticalSpace(value: 4),
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
                FocusScope.of(context).requestFocus(verifypasswordFocuse);
              },
            ),
            const VerticalSpace(value: 2),
            Text(
              LocaleKeys.VERIFY_PASSWORD.tr(),
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
              controller: verifypassword,
              focusNode: verifypasswordFocuse,
              inputType: TextInputType.text,
              isPassword: showPassword2,
              suffix: (showPassword2)
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              suffixPressed: () {
                setState(() {
                  showPassword2 = !showPassword2;
                });
              },
              validator: (value) =>
                  validateConfirmPassword(value!, password.text),
              onEditingComplete: () {
                verifypasswordFocuse.unfocus();
              },
            ),
            const VerticalSpace(value: 4),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccessState) {
                  MagicRouter.navigateAndPopAll(const LoginScreen());
                }
              },
              bloc: GetIt.I<AuthCubit>(),
              builder: (context, state) {
                return (state is! ResetPasswordLoadingState)
                    ? CustomGeneralButton(
                        text: LocaleKeys.UPDATE.tr(),
                        color: colorBetrolly,
                        textColor: Colors.white,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            GetIt.I<AuthCubit>()
                                .postResetPassword(password: password.text);
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
