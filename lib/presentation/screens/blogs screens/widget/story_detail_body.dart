import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zat/presentation/screens/blogs%20screens/cubit/blogs_cubit.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/space_widget.dart';

class StoryDetailBody extends StatefulWidget {
  final String videoId;
  final String name;
  const StoryDetailBody({super.key, required this.videoId, required this.name});

  @override
  State<StoryDetailBody> createState() => _StoryDetailBodyState();
}

class _StoryDetailBodyState extends State<StoryDetailBody> {
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogsCubit, BlogsState>(
      listener: (context, state) {},
      bloc: GetIt.I<BlogsCubit>(),
      builder: (context, state) {
        return (GetIt.I<BlogsCubit>().successStoryDetailModel != null)
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context) * 0.02,
                  horizontal: screenWidth(context) * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: youtubePlayerController!,
                      showVideoProgressIndicator: true,
                      aspectRatio: 16 / 9,
                      liveUIColor: Colors.red,
                      progressIndicatorColor: Colors.blueAccent,
                    ),
                    const VerticalSpace(value: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (GetIt.I<BlogsCubit>()
                                    .successStoryDetailModel!
                                    .data!
                                    .name !=
                                null)
                            ? Text(
                                GetIt.I<BlogsCubit>()
                                    .successStoryDetailModel!
                                    .data!
                                    .name!,
                                style: headingStyle.copyWith(
                                  fontSize: screenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                widget.name,
                                style: headingStyle.copyWith(
                                  fontSize: screenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                        (GetIt.I<BlogsCubit>()
                                    .successStoryDetailModel!
                                    .data!
                                    .views !=
                                null)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.visibility_outlined,
                                    color: colordeepGrey,
                                  ),
                                  const HorizontalSpace(value: 0.7),
                                  Text(
                                    GetIt.I<BlogsCubit>()
                                        .successStoryDetailModel!
                                        .data!
                                        .views
                                        .toString(),
                                    style: headingStyle.copyWith(
                                      color: colordeepGrey,
                                      fontSize: screenWidth(context) * 0.04,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const VerticalSpace(value: 2),
                    Text(
                      GetIt.I<BlogsCubit>().successStoryDetailModel!.data!.job!,
                      style: headingStyle.copyWith(
                        fontSize: screenWidth(context) * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const VerticalSpace(value: 2),
                    Text(
                      parseHtmlString(GetIt.I<BlogsCubit>()
                          .successStoryDetailModel!
                          .data!
                          .description!),
                      style: headingStyle.copyWith(
                        fontSize: screenWidth(context) * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            : loading();
      },
    );
  }
}
