import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/info/info.dart';
import '../../../../core/constants/colors.dart';
import '../cubit/blogs_cubit.dart';

class WriteYourBlogBody extends StatefulWidget {
  const WriteYourBlogBody({Key? key}) : super(key: key);

  @override
  State<WriteYourBlogBody> createState() => _WriteYourBlogBodyState();
}

class _WriteYourBlogBodyState extends State<WriteYourBlogBody> {
  TextEditingController message = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogsCubit, BlogsState>(
      listener: (context, state) {},
      bloc: GetIt.I<BlogsCubit>(),
      builder: (context, state) {
        return (GetIt.I<BlogsCubit>().writtingModel != null)
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight(context) * 0.04,
                  vertical: screenWidth(context) * 0.02,
                ),
                child: (GetIt.I<BlogsCubit>().writtingModel!.data!.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          GetIt.I<BlogsCubit>().writtingModel!.data!.length,
                          (index) => InkWell(
                            onTap: () => MagicRouter.navigateTo(
                              InfoScreen(
                                title: GetIt.I<BlogsCubit>()
                                    .writtingModel!
                                    .data![index]
                                    .name!,
                                content: GetIt.I<BlogsCubit>()
                                    .writtingModel!
                                    .data![index]
                                    .description!,
                                image: GetIt.I<BlogsCubit>()
                                    .writtingModel!
                                    .data![index]
                                    .image!,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: kMainColor,
                                      size: screenWidth(context) * 0.04,
                                    ),
                                    const HorizontalSpace(value: 0.7),
                                    SizedBox(
                                      width: screenWidth(context) * 0.77,
                                      child: Text(
                                        GetIt.I<BlogsCubit>()
                                            .writtingModel!
                                            .data![index]
                                            .name!,
                                        maxLines: 3,
                                        overflow: TextOverflow.fade,
                                        style: headingStyle.copyWith(
                                          color: colordeepGrey,
                                          fontSize:
                                              screenWidth(context) * 0.035,
                                          fontWeight: FontWeight.bold,
                                          height: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalSpace(value: 1),
                                (GetIt.I<BlogsCubit>()
                                            .writtingModel!
                                            .data![index]
                                            .date !=
                                        null)
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (GetIt.I<BlogsCubit>()
                                                          .writtingModel!
                                                          .data![index]
                                                          .views !=
                                                      null ||
                                                  GetIt.I<BlogsCubit>()
                                                          .writtingModel!
                                                          .data![index]
                                                          .views !=
                                                      "")
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.visibility_outlined,
                                                      color: colordeepGrey,
                                                    ),
                                                    const HorizontalSpace(
                                                        value: .5),
                                                    Text(
                                                      GetIt.I<BlogsCubit>()
                                                          .writtingModel!
                                                          .data![index]
                                                          .views!,
                                                      style:
                                                          headingStyle.copyWith(
                                                        color: colordeepGrey,
                                                        fontSize: screenWidth(
                                                                context) *
                                                            0.035,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          Text(
                                            GetIt.I<BlogsCubit>()
                                                .writtingModel!
                                                .data![index]
                                                .date!
                                                .substring(0, 10)
                                                .toString(),
                                            style: headingStyle.copyWith(
                                              color: colorGrey,
                                              fontSize:
                                                  screenWidth(context) * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const VerticalSpace(value: 3),
                              ],
                            ),
                          ),
                        ),
                        // Text(
                        //   LocaleKeys.WRITE_BLOG.tr(),
                        //   style: headingStyle.copyWith(
                        //     color: colordeepGrey,
                        //     fontSize: screenWidth(context) * 0.05,
                        //     fontWeight: FontWeight.bold,
                        //     height: 2,
                        //   ),
                        // ),
                        // const VerticalSpace(value: 2),
                        // CustomTextFormField(
                        //   hint: LocaleKeys.WRITE_YOUR_STORY.tr(),
                        //   controller: message,
                        //   maxLines: 15,
                        //   validator: (value) => validate(value!),
                        // ),
                        // const VerticalSpace(value: 4),
                        // SizedBox(
                        //   height: screenHeight(context) * 0.05,
                        //   child: CustomGeneralButton(
                        //     text: LocaleKeys.PUBLISH_NOW.tr(),
                        //     color: kMainColor,
                        //     textColor: Colors.white,
                        //     onTap: () {
                        //       if (formKey.currentState!.validate()) {
                        //         MagicRouter.pop();
                        //       }
                        //     },
                        //   ),
                        // ),
                      )
                    : Center(
                        child: Text(
                          translateString(
                              "No writting here yet", "لا توجد مقالات بعد", ""),
                          style: headingStyle.copyWith(
                            color: kMainColor,
                          ),
                        ),
                      ),
              )
            : loading();
      },
    );
  }
}
