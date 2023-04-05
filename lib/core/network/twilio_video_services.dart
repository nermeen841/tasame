// // ignore_for_file: avoid_print, deprecated_member_use, depend_on_referenced_packages

// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:twilio_programmable_video/twilio_programmable_video.dart';
// import 'package:zat/core/constants/constants.dart';

// class TwilioFunctionsService {
//   TwilioFunctionsService._();
//   static final instance = TwilioFunctionsService._();
//   Room? room;
//   final Completer<Room> completer = Completer<Room>();
//   String? token;
//   final http.Client client = http.Client();
//   final accessTokenUrl = 'https://zat-4125.twil.io/accesstoken';

//   Future<dynamic> createToken(String identity) async {
//     try {
//       Map<String, String> header = {
//         'Content-Type': 'application/json',
//       };
//       var url = Uri.parse('$accessTokenUrl?user=$identity');
//       final response = await client.get(url, headers: header);
//       Map<String, dynamic> responseMap = jsonDecode(response.body);
//       prefs.setString("video_call", responseMap['accessToken'].toString());
//       print(responseMap);
//       return responseMap;
//     } catch (error) {
//       throw Exception([error.toString()]);
//     }
//   }

//   void onConnected(Room room) {
//     print('Connected to ${room.name}');
//     completer.complete(room);
//   }

//   void onConnectFailure(RoomConnectFailureEvent event) {
//     print(
//         'Failed to connect to room ${event.room.name} with exception: ${event.exception}');
//     completer.completeError(event.exception!);
//   }

//   Future<Room> connectToRoom() async {
//     // Retrieve the camera source of your choosing
//     var cameraSources = await CameraSource.getSources();
//     var cameraCapturer = CameraCapturer(
//       cameraSources.firstWhere((source) => source.isFrontFacing),
//     );
//     var nativeEnabled = true;
//     var dartEnabled = true;
//     TwilioProgrammableVideo.debug(native: nativeEnabled, dart: dartEnabled);
//     await TwilioProgrammableVideo.setSpeakerphoneOn(true);
//     var connectOptions = ConnectOptions(
//       prefs.getString("video_call").toString(),
//       roomName: "zat video room",
//       region: Region.us1,
//       enableNetworkQuality: true,
//       enableAutomaticSubscription: true,
//       enableDominantSpeaker: true,
//       preferredAudioCodecs: [
//         OpusCodec()
//       ], // Optional list of preferred AudioCodecs
//       preferredVideoCodecs: [
//         H264Codec()
//       ], // Optional list of preferred VideoCodecs.
//       audioTracks: [
//         LocalAudioTrack(true, "")
//       ], // Optional list of audio tracks.                                   // Optional list of data tracks
//       videoTracks: [
//         LocalVideoTrack(true, cameraCapturer)
//       ], // Optional list of video tracks.
//     );
//     room = await TwilioProgrammableVideo.connect(connectOptions);
//     room!.onConnected.listen(onConnected);
//     room!.onConnectFailure.listen(onConnectFailure);
//     return completer.future;
//   }
// }
