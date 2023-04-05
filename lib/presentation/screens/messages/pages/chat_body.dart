import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/messages/cubit/chat_cubit.dart';
import 'package:zat/presentation/screens/messages/widget/chat_view.dart';
import 'package:zat/presentation/screens/messages/widget/cht_body_appbar.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';

class ChatBodyScreen extends StatefulWidget {
  final int recieverId;
  final String recieverName;
  final String recieverImage;
  const ChatBodyScreen(
      {super.key,
      required this.recieverId,
      required this.recieverName,
      required this.recieverImage});

  @override
  State<ChatBodyScreen> createState() => _ChatBodyScreenState();
}

class _ChatBodyScreenState extends State<ChatBodyScreen> {
  @override
  void initState() {
    GetIt.I<ProfileCubit>().getUserProfile();
    GetIt.I<ChatCubit>().getCommunicationsMethode();
    GetIt.I<ChatCubit>().changeRateValue(0.0);
    GetIt.I<ChatCubit>().ratting = 0.0;
    super.initState();
  }

  double retting = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatbodyAppbar(
        title: widget.recieverName,
        context: context,
        image: widget.recieverImage,
        tutorId: widget.recieverId,
      ),
      body: ChatView(
        recieverId: widget.recieverId,
      ),
    );
  }
}

// void communicationTypesAlert(context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         scrollable: false,
//         contentPadding: EdgeInsets.zero,
//         insetPadding: EdgeInsets.all(screenWidth(context) * 0.03),
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: Colors.white, width: 3),
//           borderRadius: BorderRadius.circular(screenWidth(context) * 0.01),
//         ),
//         title: Builder(
//           builder: (context) => Container(
//             width: 500,
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth(context) * 0.03,
//               vertical: screenHeight(context) * 0.03,
//             ),
//             child: SingleChildScrollView(
//               child: BlocProvider(
//                 create: (context) =>
//                     RoomCubit(backendService: TwilioFunctionsService.instance),
//                 child: BlocConsumer<RoomCubit, RoomState>(
//                   listener: (context, state) async {
//                     if (state is RoomLoaded) {
//                       GetIt.I<ConferenceCubitCubit>().connect(state.identity);
//                     }
//                   },
//                   builder: (context, state) {
//                     RoomCubit bloc = context.read<RoomCubit>();
//                     return Column(
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional.topEnd,
//                           child: TextButton(
//                             onPressed: () => MagicRouter.pop(),
//                             child: Text(
//                               translateString("Close", "اغلاق", "kapat"),
//                               style: headingStyle.copyWith(
//                                 color: colorRed,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: screenWidth(context) * 0.045,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const VerticalSpace(value: 1),
//                         BlocConsumer<ChatCubit, ChatState>(
//                           bloc: GetIt.I<ChatCubit>(),
//                           builder: (context, state) =>
//                               (GetIt.I<ChatCubit>().communicationsModel != null)
//                                   ? Column(
//                                       children: List.generate(
//                                         GetIt.I<ChatCubit>()
//                                             .communicationsModel!
//                                             .data!
//                                             .length,
//                                         (index) => ListTile(
//                                           textColor: Colors.black,
//                                           onTap: () async {
//                                             if (GetIt.I<ChatCubit>()
//                                                     .communicationsModel!
//                                                     .data![index]
//                                                     .name! ==
//                                                 "Twilio") {
//                                               context.read<RoomCubit>().name =
//                                                   (prefs.getString(
//                                                               "user_type") ==
//                                                           "user")
//                                                       ? GetIt.I<ProfileCubit>()
//                                                           .userModel!
//                                                           .data!
//                                                           .name!
//                                                       : GetIt.I<ProfileCubit>()
//                                                           .tutorProfileModel!
//                                                           .data!
//                                                           .name!;
//                                               await bloc.submit();
//                                             } else if (GetIt.I<ChatCubit>()
//                                                     .communicationsModel!
//                                                     .data![index]
//                                                     .name! ==
//                                                 "Agora") {
//                                               MagicRouter.navigateTo(
//                                                   const AgoraVideoCallScreen());
//                                             } else {}
//                                           },
//                                           title: Text(
//                                             GetIt.I<ChatCubit>()
//                                                     .communicationsModel!
//                                                     .data![index]
//                                                     .name ??
//                                                 "",
//                                             style: headingStyle.copyWith(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize:
//                                                   screenWidth(context) * 0.045,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Center(
//                                       child: CircularProgressIndicator(
//                                         color: kMainColor,
//                                       ),
//                                     ),
//                           listener: (context, state) {},
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
