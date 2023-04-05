// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
// import 'package:zat/core/constants/colors.dart';
// import 'package:zat/core/constants/constants.dart';
// import 'package:zat/core/network/constants.dart';
// import 'package:zat/core/router/router.dart';

// class AgoraVideoCallScreen extends StatefulWidget {
//   const AgoraVideoCallScreen({Key? key}) : super(key: key);

//   @override
//   State<AgoraVideoCallScreen> createState() => _AgoraVideoCallScreenState();
// }

// class _AgoraVideoCallScreenState extends State<AgoraVideoCallScreen> {
//   int? remoteUid;
//   bool localUserJoined = false;
//   bool muteAvailable = false;
//   late RtcEngine _engine;

//   @override
//   void initState() {
//     getToken();
//     WidgetsBinding.instance.addPostFrameCallback((context) {
//       initAgora();
//     });
//     super.initState();
//   }

//   String tempToken = "";

//   Future<void> getToken() async {
//     String link =
//         "https://zat-front.vercel.app/api/agora?channelName=$channelName";

//     var response = await http.get(Uri.parse(link));
//     Map data = jsonDecode(response.body);
//     setState(() {
//       tempToken = data["token"];
//     });
//   }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: agoraAppID,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             remoteUid = 0;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );

//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();

//     await _engine.joinChannel(
//       token: tempToken,
//       channelId: channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(
//         publishCameraTrack: true,
//         publishMicrophoneTrack: true,
//         publishScreenCaptureAudio: true,
//         publishScreenCaptureVideo: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         toolbarHeight: 0.0,
//       ),
//       body: Stack(
//         alignment: AlignmentDirectional.bottomCenter,
//         children: [
//           Column(
//             children: [
//               SizedBox(
//                 width: screenWidth(context),
//                 height: screenHeight(context) / 2,
//                 child: localUserJoined
//                     ? AgoraVideoView(
//                         controller: VideoViewController(
//                           rtcEngine: _engine,
//                           useAndroidSurfaceView: true,
//                           canvas: const VideoCanvas(uid: 0),
//                         ),
//                       )
//                     : Center(
//                         child: CircularProgressIndicator(
//                           color: kMainColor,
//                         ),
//                       ),
//               ),
//               SizedBox(
//                 width: screenWidth(context),
//                 height: screenHeight(context) / 2,
//                 child: _remoteVideo(),
//               ),
//             ],
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   _engine.leaveChannel();
//                   MagicRouter.pop();
//                 },
//                 icon: Icon(
//                   Icons.call_end,
//                   color: colorRed,
//                   size: screenWidth(context) * 0.1,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     muteAvailable = !muteAvailable;
//                   });
//                   _engine.muteLocalAudioStream(muteAvailable);
//                 },
//                 icon: Icon(
//                   (!muteAvailable) ? Icons.mic_rounded : Icons.mic_off,
//                   color: Colors.blue,
//                   size: screenWidth(context) * 0.1,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           useAndroidSurfaceView: true,
//           canvas: VideoCanvas(uid: remoteUid),
//           connection: RtcConnection(channelId: channelName),
//         ),
//       );
//     } else {
//       return Padding(
//         padding: EdgeInsets.only(top: screenHeight(context) * 0.1),
//         child: const Text(
//           'Please wait for remote user to join',
//           textAlign: TextAlign.center,
//         ),
//       );
//     }
//   }
// }
