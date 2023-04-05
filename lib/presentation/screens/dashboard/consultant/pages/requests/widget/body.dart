import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';

import '../../../../../../../core/constants/colors.dart';

class AllRequestBody extends StatefulWidget {
  const AllRequestBody({super.key});

  @override
  State<AllRequestBody> createState() => _AllRequestBodyState();
}

class _AllRequestBodyState extends State<AllRequestBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: GetIt.I<HomeCubit>(),
      listener: (context, state) {},
      builder: (context, state) => (GetIt.I<HomeCubit>().allRequestModel !=
              null)
          ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight(context) * 0.02,
                horizontal: screenWidth(context) * 0.02,
              ),
              child: (GetIt.I<HomeCubit>().allRequestModel!.data!.isNotEmpty)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        GetIt.I<HomeCubit>().allRequestModel!.data!.length,
                        (index) => Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context) * 0.02,
                            vertical: screenHeight(context) * 0.015,
                          ),
                          margin: EdgeInsets.all(
                            screenWidth(context) * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              screenWidth(context) * 0.015,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorGrey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                GetIt.I<HomeCubit>()
                                    .allRequestModel!
                                    .data![index]
                                    .user!,
                                style: headingStyle.copyWith(
                                  color: colordeepGrey,
                                  fontSize: screenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const VerticalSpace(value: 1),
                              Text(
                                GetIt.I<HomeCubit>()
                                    .allRequestModel!
                                    .data![index]
                                    .message!,
                                style: headingStyle.copyWith(
                                  color: colordeepGrey,
                                  fontSize: screenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const VerticalSpace(value: 1),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Text(
                                  "${GetIt.I<HomeCubit>().allRequestModel!.data![index].createdAt!.substring(0, 10)}  -  ${GetIt.I<HomeCubit>().allRequestModel!.data![index].createdAt!.substring(11, 18)}",
                                  style: headingStyle.copyWith(
                                    color: colorGrey,
                                    fontSize: screenWidth(context) * 0.035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        translateString("No Requsts here yet ",
                            "لا توجد طلبات مواعيد خاصة بعد ", ""),
                        style: headingStyle.copyWith(
                          color: kMainColor,
                          fontSize: screenWidth(context) * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            )
          : loading(),
    );
  }
}
