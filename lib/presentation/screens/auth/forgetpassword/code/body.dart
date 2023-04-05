import 'package:flutter/material.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/auth/forgetpassword/reset_password/reset_password.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../generator/locale_keys.dart';
import '../../../dashboard/consultant/pages/upcomming_consultation/upcomming_consultation.dart';
import '../../../dashboard/user/upcommingconsultation/upcomming_consultation.dart';
import '../../bloc/Auth_cubit/auth_cubit.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CodeBody extends StatefulWidget {
  final bool fromLogin;
  const CodeBody({Key? key, required this.fromLogin}) : super(key: key);

  @override
  State<CodeBody> createState() => _CodeBodyState();
}

class _CodeBodyState extends State<CodeBody> {
  TextEditingController code = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight(context) * 0.02,
          horizontal: screenWidth(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalSpace(value: 4),
            Center(
              child: Text(
                translateString(
                    "Please enter code sent to your phone",
                    "من فضلك ادخل الكود المرسل لرقم هاتفك",
                    "Lütfen telefonunuza gönderilen kodu giriniz"),
              ),
            ),
            const VerticalSpace(value: 2),
            CustomTextFormField(
              controller: code,
              validator: (value) {
                if (value!.isEmpty) {
                  return translateString(
                      "please enter verification code",
                      "من فضلك ادخل كود التفعيل",
                      "lütfen doğrulama kodunu giriniz");
                } else {
                  if (value.length != prefs.getString("code")!.length) {
                    return translateString(
                        "code is invalid", "الكود غير صحيح", "kod geçersiz");
                  }
                }
                return null;
              },
              hint: translateString("verification coed", "كود التفعيل",
                  "doğrulama karma eğitimi"),
            ),
            const VerticalSpace(value: 4),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (widget.fromLogin) {
                  if (state is ConfirmCodeSuccessState) {
                    if (prefs.getString("user_type") == "user") {
                      MagicRouter.navigateAndPopAll(
                          UpcommingConsultationsScreen(
                              fromAuth: true,
                              title: translateString(
                                  "Upcomming Consultations",
                                  "الاستشارات القادمة",
                                  "Yaklaşan İstişareler")));
                    } else {
                      MagicRouter.navigateAndPopAll(UpcommingConsultationTutor(
                          fromAuth: true,
                          title: translateString("Upcomming Consultations",
                              "الاستشارات القادمة", "Yaklaşan İstişareler")));
                    }
                  }
                } else {
                  if (state is ConfirmCodeSuccessState) {
                    MagicRouter.navigateAndPopAll(const ResetPasswordScreen());
                  }
                }
              },
              bloc: GetIt.I<AuthCubit>(),
              builder: (context, state) {
                return (state is! LoginLoadingState)
                    ? CustomGeneralButton(
                        text: LocaleKeys.SEND.tr(),
                        color: colorBetrolly,
                        textColor: Colors.white,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            GetIt.I<AuthCubit>()
                                .postConfirmCode(code: code.text);
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
