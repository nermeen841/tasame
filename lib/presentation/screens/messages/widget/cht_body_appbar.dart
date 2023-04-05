import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';

AppBar chatbodyAppbar({
  required String title,
  required context,
  required String image,
  required int tutorId,
}) {
  return AppBar(
    actions: [
      (prefs.getString("user_type") == "user")
          ? TextButton(
              onPressed: () {},
              child: Text(
                translateString("rate", "التقييم", "oran"),
              ),
            )
          : const SizedBox(),
      // BlocProvider(
      //   create: (context) =>
      //       RoomCubit(backendService: TwilioFunctionsService.instance),
      //   child: BlocConsumer<RoomCubit, RoomState>(
      //     listener: (context, state) async {
      //       if (state is RoomLoaded) {
      //         GetIt.I<ConferenceCubitCubit>().connect(state.identity);
      //       }
      //     },
      //     builder: (context, state) {
      //       RoomCubit bloc = context.read<RoomCubit>();
      //       return IconButton(
      //         onPressed: () async {
      //           if (GetIt.I<ChatCubit>().communicationsModel!.data!.name! ==
      //               "Twilio") {
      //             context.read<RoomCubit>().name =
      //                 (prefs.getString("user_type") == "user")
      //                     ? GetIt.I<ProfileCubit>().userModel!.data!.name!
      //                     : GetIt.I<ProfileCubit>()
      //                         .tutorProfileModel!
      //                         .data!
      //                         .name!;
      //             await bloc.submit();
      //           } else if (GetIt.I<ChatCubit>()
      //                   .communicationsModel!
      //                   .data!
      //                   .name! ==
      //               "Agora") {
      //             // MagicRouter.navigateTo(const AgoraVideoCallScreen());
      //           } else {}
      //         },
      //         icon: BlocConsumer<ChatCubit, ChatState>(
      //           bloc: GetIt.I<ChatCubit>(),
      //           listener: (context, state) {},
      //           builder: (context, state) {
      //             return Icon(
      //               Icons.video_call,
      //               color: kMainColor,
      //               size: screenWidth(context) * 0.1,
      //             );
      //           },
      //         ),
      //       );
      //     },
      //   ),
      // ),
    ],
    leading: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => MagicRouter.pop(),
          child: const Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        CircleAvatar(
          radius: screenWidth(context) * 0.04,
          backgroundColor: kMainColor,
          backgroundImage: NetworkImage(image),
        ),
      ],
    ),
    elevation: 0,
    centerTitle: false,
    title: Text(
      title,
      style: headingStyle.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: screenWidth(context) * 0.035,
        color: colordeepGrey,
      ),
    ),
  );
}
