// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, library_private_types_in_public_api

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:zat/core/network/constants.dart';
// import 'package:zoom/zoom.dart';

// class ZoomMeetingScreen extends StatefulWidget {
//   final String userName;
//   const ZoomMeetingScreen({super.key, required this.userName});

//   @override
//   _ZoomMeetingScreenState createState() => _ZoomMeetingScreenState();
// }

// class _ZoomMeetingScreenState extends State<ZoomMeetingScreen> {
//   TextEditingController meetingIdController = TextEditingController();
//   TextEditingController meetingPasswordController = TextEditingController();
//   Timer? timer;
//   @override
//   Widget build(BuildContext context) {
//     // new page needs scaffolding!
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Join meeting'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 8.0,
//           horizontal: 32.0,
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: TextField(
//                   controller: meetingIdController,
//                   decoration: const InputDecoration(
//                     labelText: 'Meeting ID',
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: TextField(
//                   controller: meetingPasswordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Meeting Password',
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Builder(
//                 builder: (context) {
//                   // The basic Material Design action button.
//                   return ElevatedButton(
//                     // If onPressed is null, the button is disabled
//                     // this is my goto temporary callback.
//                     onPressed: () => joinMeeting(context),
//                     child: const Text('Join'),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Builder(
//                 builder: (context) {
//                   // The basic Material Design action button.
//                   return ElevatedButton(
//                     // If onPressed is null, the button is disabled
//                     // this is my goto temporary callback.
//                     onPressed: () => startMeeting(context),
//                     child: const Text('Start Meeting'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool _isMeetingEnded(String status) {
//     if (Platform.isAndroid) {
//       return status == "MEETING_STATUS_DISCONNECTING" ||
//           status == "MEETING_STATUS_FAILED";
//     }
//     return status == "MEETING_STATUS_ENDED";
//   }

//   joinMeeting(BuildContext context) {
//     ZoomOptions zoomOptions = ZoomOptions(
//       domain: "zoom.us",
//       // jwtToken: "eo3qrIJ3TnqV2br8E1lLSg",
//       appKey: zoomApiKey,
//       appSecret: zoomApiSecret,
//     );
//     var meetingOptions = ZoomMeetingOptions(
//         userId: widget.userName,
//         meetingId: meetingIdController.text,
//         meetingPassword: meetingPasswordController.text,
//         disableDialIn: "true",
//         disableDrive: "true",
//         disableInvite: "true",
//         disableShare: "true",
//         noAudio: "false",
//         noDisconnectAudio: "false",
//         meetingViewOptions: ZoomMeetingOptions.NO_TEXT_PASSWORD +
//             ZoomMeetingOptions.NO_TEXT_MEETING_ID +
//             ZoomMeetingOptions.NO_BUTTON_PARTICIPANTS);
//     var zoom = Zoom();
//     zoom.init(zoomOptions).then((results) {
//       if (results[0] == 0) {
//         zoom.onMeetingStateChanged.listen((status) {
//           print("${"Meeting Status Stream: " + status[0]} - " + status[1]);
//           if (_isMeetingEnded(status[0])) {
//             timer?.cancel();
//           }
//         });
//         zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
//           timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//             zoom.meetingStatus(meetingOptions.meetingId).then((status) {
//               print("Meeting Status Polling: " + status[0] + " - " + status[1]);
//             });
//           });
//         });
//       }
//     });
//   }

//   startMeeting(BuildContext context) {}
// }
