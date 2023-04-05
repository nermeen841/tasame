import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/auth/login/login.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../auth/register/register.dart';
import '../../contactus/cubit/setting_cubit.dart';
import 'splash_content.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  int currentPage = 0;
  PageController? pageController;

  @override
  void initState() {
    GetIt.I<SettingCubit>().getAppIntro();
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {},
      bloc: GetIt.I<SettingCubit>(),
      builder: (context, state) {
        return (GetIt.I<SettingCubit>().appIntroModel != null)
            ? SizedBox(
                width: double.infinity,
                height: screenHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount:
                            GetIt.I<SettingCubit>().appIntroModel!.data!.length,
                        itemBuilder: (context, index) {
                          return SplashContent(
                            image: GetIt.I<SettingCubit>()
                                .appIntroModel!
                                .data![index]
                                .image!,
                            title: GetIt.I<SettingCubit>()
                                .appIntroModel!
                                .data![index]
                                .title!,
                            text: GetIt.I<SettingCubit>()
                                .appIntroModel!
                                .data![index]
                                .subtitle!,
                          );
                          // if (index == currentPage.floor()) {
                          //   return Transform(
                          //     transform: Matrix4.identity()
                          //       ..rotateX(double.parse(currentPage.toString()) - index),
                          //     // ..rotateZ(double.parse(currentPage.toString()) - index),
                          //     child: const
                          //   );
                          // } else if (index == currentPage.floor() + 1) {
                          //   return Transform(
                          //     transform: Matrix4.identity()
                          //       ..rotateX(double.parse(currentPage.toString()) - index)
                          //     // ..rotateZ(double.parse(currentPage.toString()) - index),
                          //     ,
                          //     child: const SplashContent(
                          //       image:
                          //           "https://img.freepik.com/free-photo/person-drawing-symbols-coming-out-light-bulb-top-book_1232-909.jpg?w=360&t=st=1670972298~exp=1670972898~hmac=7d96641cba16239985e5d2180b9b31c3225b7477e62b524460a3d4fa98fc3798",
                          //       title: "Becom one of our 40.000 Students",
                          //       text:
                          //           "we are most preferred turkish learning platform \n in the world",
                          //     ),
                          //   );
                          // } else {
                          //   return const SplashContent(
                          //     image:
                          //         "https://img.freepik.com/free-photo/person-drawing-symbols-coming-out-light-bulb-top-book_1232-909.jpg?w=360&t=st=1670972298~exp=1670972898~hmac=7d96641cba16239985e5d2180b9b31c3225b7477e62b524460a3d4fa98fc3798",
                          //     title: "Becom one of our 40.000 Students",
                          //     text:
                          //         "we are most preferred turkish learning platform \n in the world",
                          //   );
                          // }
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        GetIt.I<SettingCubit>().appIntroModel!.data!.length,
                        (index) => buildOnBoardingDot(
                            index: index,
                            currentPage: currentPage,
                            context: context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context) * 0.04,
                          vertical: screenHeight(context) * 0.01),
                      child: CustomGeneralButton(
                        text: LocaleKeys.SIGNUP_BUTTON.tr(),
                        textColor: Colors.white,
                        onTap: () {
                          MagicRouter.navigateTo(const RegisterScreen());
                        },
                      ),
                    ),
                    const VerticalSpace(value: 1),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context) * 0.04,
                      ),
                      child: CustomGeneralButton(
                        text: LocaleKeys.LOGIN_BUTTON.tr(),
                        borderColor: kMainColor,
                        color: Colors.white,
                        textColor: kMainColor,
                        onTap: () =>
                            MagicRouter.navigateTo(const LoginScreen()),
                      ),
                    ),
                    const VerticalSpace(value: 2),
                  ],
                ),
              )
            : loading();
      },
    );
  }
}

AnimatedContainer buildOnBoardingDot(
    {required int index, required int currentPage, required context}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    margin: const EdgeInsets.all(5),
    height: screenHeight(context) * 0.04,
    width: currentPage == index
        ? screenWidth(context) * 0.045
        : screenWidth(context) * 0.035,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: currentPage == index ? kMainColor : Colors.white,
      border: Border.all(color: kMainColor),
    ),
  );
}
