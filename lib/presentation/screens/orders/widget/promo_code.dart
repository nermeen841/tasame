import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/orders/cubit/orders_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../generator/locale_keys.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({Key? key}) : super(key: key);

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  TextEditingController code = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "", context: context),
      body: Form(
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
                    if (value.length != 6) {
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
              BlocConsumer<OrdersCubit, OrdersState>(
                listener: (context, state) {},
                bloc: GetIt.I<OrdersCubit>(),
                builder: (context, state) {
                  return (state is! SendPromoCodeLoadingState)
                      ? CustomGeneralButton(
                          text: LocaleKeys.SEND.tr(),
                          color: colorBetrolly,
                          textColor: Colors.white,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              GetIt.I<OrdersCubit>().sendPromoCode(code.text);
                            }
                          },
                        )
                      : loading();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
