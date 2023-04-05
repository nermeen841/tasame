import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/widgets/space_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../contactus/cubit/setting_cubit.dart';
import 'offer_slider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  @override
  void initState() {
    GetIt.I<SettingCubit>().getSettingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {},
      bloc: GetIt.I<SettingCubit>(),
      builder: (context, state) {
        return (GetIt.I<SettingCubit>().settingModel != null)
            ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth(context) * 0.25,
                        height: screenHeight(context) * 0.1,
                        child: customCachedNetworkImage(
                          url:
                              GetIt.I<SettingCubit>().settingModel!.data!.logo!,
                          context: context,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const HorizontalSpace(value: 1),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            GetIt.I<SettingCubit>()
                                .settingModel!
                                .data!
                                .titleSlider!,
                            style: headingStyle.copyWith(
                              color: colordeepGrey,
                              fontSize: screenWidth(context) * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const VerticalSpace(value: 0.7),
                          SizedBox(
                            width: screenWidth(context) * 0.6,
                            child: Wrap(
                              children: [
                                Text(
                                  parseHtmlString(GetIt.I<SettingCubit>()
                                      .settingModel!
                                      .data!
                                      .textSlider!),
                                  style: headingStyle.copyWith(
                                    color: colorGrey,
                                    height: 1.3,
                                    fontSize: screenWidth(context) * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpace(value: 2),
                  const OfferSliderItem(),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
