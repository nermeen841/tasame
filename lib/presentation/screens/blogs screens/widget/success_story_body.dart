// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/blogs%20screens/cubit/blogs_cubit.dart';

import '../pages/story_detail.dart';

class SuccessStoryBody extends StatefulWidget {
  final int isAdmin;
  const SuccessStoryBody({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<SuccessStoryBody> createState() => _SuccessStoryBodyState();
}

class _SuccessStoryBodyState extends State<SuccessStoryBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogsCubit, BlogsState>(
      listener: (context, state) {},
      bloc: GetIt.I<BlogsCubit>(),
      builder: (context, state) {
        return (GetIt.I<BlogsCubit>().storiesModel != null)
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context) * 0.02,
                  horizontal: screenWidth(context) * 0.04,
                ),
                child: (GetIt.I<BlogsCubit>().storiesModel!.data!.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (widget.isAdmin != 1)
                              ? Text(
                                  LocaleKeys.SUCCESS_STORY_MESSAGE.tr(),
                                  style: headingStyle.copyWith(
                                    color: colordeepGrey,
                                    fontSize: screenWidth(context) * 0.05,
                                    fontWeight: FontWeight.bold,
                                    height: 2,
                                  ),
                                )
                              : const SizedBox(),
                          (widget.isAdmin != 1)
                              ? const VerticalSpace(value: 2)
                              : const SizedBox(),
                          Column(
                            children: List.generate(
                              GetIt.I<BlogsCubit>().storiesModel!.data!.length,
                              (index) {
                                final String id = YoutubePlayer.convertUrlToId(
                                    GetIt.I<BlogsCubit>()
                                            .storiesModel!
                                            .data![index]
                                            .video ??
                                        "https://www.youtube.com/watch?v=8r2SIJw5RAQ")!;
                                print(id);

                                final ytController = YoutubePlayerController(
                                  initialVideoId: id,
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    enableCaption: false,
                                  ),
                                );
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    YoutubePlayer(
                                      controller: ytController,
                                      showVideoProgressIndicator: true,
                                      aspectRatio: 16 / 9,
                                      liveUIColor: Colors.red,
                                      progressIndicatorColor: Colors.blueAccent,
                                    ),
                                    const VerticalSpace(value: 2),
                                    InkWell(
                                      onTap: () {
                                        GetIt.I<BlogsCubit>()
                                            .getSuccessStoriesDetail(
                                                GetIt.I<BlogsCubit>()
                                                    .storiesModel!
                                                    .data![index]
                                                    .id!);
                                        MagicRouter.navigateTo(
                                            StoryDetailScreen(
                                          videoId: id,
                                          name: GetIt.I<BlogsCubit>()
                                              .storiesModel!
                                              .data![index]
                                              .name!,
                                        ));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (GetIt.I<BlogsCubit>()
                                                      .storiesModel!
                                                      .data![index]
                                                      .name !=
                                                  null)
                                              ? Text(
                                                  GetIt.I<BlogsCubit>()
                                                      .storiesModel!
                                                      .data![index]
                                                      .name!,
                                                  style: headingStyle.copyWith(
                                                    fontSize:
                                                        screenWidth(context) *
                                                            0.04,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          (GetIt.I<BlogsCubit>()
                                                      .storiesModel!
                                                      .data![index]
                                                      .views !=
                                                  null)
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
                                                        value: 0.7),
                                                    Text(
                                                      GetIt.I<BlogsCubit>()
                                                          .storiesModel!
                                                          .data![index]
                                                          .views!,
                                                      style:
                                                          headingStyle.copyWith(
                                                        color: colordeepGrey,
                                                        fontSize: screenWidth(
                                                                context) *
                                                            0.04,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    const VerticalSpace(value: 4),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          translateString("No success stories here ",
                              "لا توجد قصص نجاح", ""),
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
