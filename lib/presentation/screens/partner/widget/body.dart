// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';

class PartnerBody extends StatefulWidget {
  const PartnerBody({super.key});

  @override
  State<PartnerBody> createState() => _PartnerBodyState();
}

class _PartnerBodyState extends State<PartnerBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return (GetIt.I<HomeCubit>().partnerModel != null)
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context) * 0.02,
                  horizontal: screenWidth(context) * 0.02,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 30,
                  spacing: 10,
                  children: List.generate(
                    GetIt.I<HomeCubit>().partnerModel!.data!.length,
                    (index) => SizedBox(
                      width: screenWidth(context) * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth(context) * 0.3,
                            height: screenHeight(context) * 0.15,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                screenWidth(context) * 0.04,
                              ),
                              child: customCachedNetworkImage(
                                  fit: BoxFit.cover,
                                  url: GetIt.I<HomeCubit>()
                                      .partnerModel!
                                      .data![index]
                                      .logo!,
                                  context: context),
                            ),
                          ),
                          const VerticalSpace(value: 1),
                          Text(
                            GetIt.I<HomeCubit>()
                                    .partnerModel!
                                    .data![index]
                                    .name ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                          const VerticalSpace(value: 1),
                          InkWell(
                            onTap: () async => await launch(GetIt.I<HomeCubit>()
                                .partnerModel!
                                .data![index]
                                .link!),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.launch_outlined,
                                  color: kMainColor,
                                ),
                                const HorizontalSpace(value: 0.7),
                                Text(
                                  translateString(
                                      "Partner website", "صفحة الشريك", ""),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : loading();
      },
    );
  }
}
