// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, avoid_print

// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:twilio_programmable_video/twilio_programmable_video.dart';
// import 'package:collection/collection.dart' show IterableExtension;
// import 'package:uuid/uuid.dart';
// import 'package:zat/core/router/router.dart';
// import 'package:zat/presentation/twilio/conference/conference_page.dart';
// import '../../../../core/constants/constants.dart';
// import '../participant_widget.dart';
// part 'conference_cubit_state.dart';

// class ConferenceCubitCubit extends Cubit<ConferenceCubitState> {
//   ConferenceCubitCubit() : super(ConferenceCubitInitial());

//   final List<ParticipantWidget> _participants = [];

//   late Room room;
//   late VideoCapturer cameraCapturer;
//   late List<StreamSubscription> streamSubscriptions = [];

//   List<ParticipantWidget> get participants {
//     return [..._participants];
//   }

//   ParticipantWidget buildParticipant({
//     required Widget child,
//     required String? id,
//   }) {
//     return ParticipantWidget(
//       id: id,
//       child: child,
//     );
//   }

//   connect(identity) async {
//     print('[ APPDEBUG ] ConferenceRoom.connect()');
//     emit(ConferenceInitial());
//     try {
//       await TwilioProgrammableVideo.setSpeakerphoneOn(true);

//       final sources = await CameraSource.getSources();
//       cameraCapturer = CameraCapturer(
//         sources.firstWhere((source) => source.isFrontFacing),
//       );
//       final trackId = const Uuid().v4();

//       var connectOptions = ConnectOptions(
//         prefs.getString("video_call").toString(),
//         roomName: "zat video room",
//         preferredAudioCodecs: [OpusCodec()],
//         audioTracks: [LocalAudioTrack(true, 'audio_track-$trackId')],
//         dataTracks: [
//           LocalDataTrack(
//             DataTrackOptions(name: 'data_track-$trackId'),
//           )
//         ],
//         videoTracks: [LocalVideoTrack(true, cameraCapturer)],
//         enableNetworkQuality: true,
//         networkQualityConfiguration: NetworkQualityConfiguration(
//           remote: NetworkQualityVerbosity.NETWORK_QUALITY_VERBOSITY_MINIMAL,
//         ),
//         enableDominantSpeaker: true,
//         enableAutomaticSubscription: true,
//       );

//       room = await TwilioProgrammableVideo.connect(connectOptions);

//       streamSubscriptions.add(
//         room.onConnected.listen(
//           (room) {
//             print(
//                 '[ APPDEBUG ] ConferenceRoom._onConnected => state: ${room.state} , ${room.name}');

//             // When connected for the first time, add remote participant listeners
//             streamSubscriptions.add(
//                 room.onParticipantConnected.listen(onParticipantConnected));
//             streamSubscriptions.add(room.onParticipantDisconnected
//                 .listen(onParticipantDisconnected));
//             final localParticipant = room.localParticipant;
//             if (localParticipant == null) {
//               print(
//                   '[ APPDEBUG ] ConferenceRoom._onConnected => localParticipant is null');
//               return;
//             }

//             // Only add ourselves when connected for the first time too.
//             _participants.add(buildParticipant(
//                 child: localParticipant.localVideoTracks[0].localVideoTrack
//                     .widget(),
//                 id: identity));

//             for (final remoteParticipant in room.remoteParticipants) {
//               var participant = _participants.firstWhereOrNull(
//                   (participant) => participant.id == remoteParticipant.sid);
//               if (participant == null) {
//                 print(
//                     '[ APPDEBUG ] Adding participant that was already present in the room ${remoteParticipant.sid}, before I connected');
//                 addRemoteParticipantListeners(remoteParticipant);
//               }
//             }
//             MagicRouter.navigateTo(const ConferencePage());
//             emit(ConferenceLoaded());
//           },
//         ),
//       );

//       streamSubscriptions.add(room.onDisconnected.listen(onDisconnected));
//       streamSubscriptions.add(room.onReconnecting.listen(onReconnecting));
//       streamSubscriptions.add(room.onConnectFailure.listen(onConnectFailure));
//     } catch (err) {
//       print('[ APPDEBUG ] $err');
//       rethrow;
//     }
//   }

//   Future<void> disconnect() async {
//     print('[ APPDEBUG ] ConferenceRoom.disconnect()');
//     await room.disconnect();
//   }

//   void onDisconnected(RoomDisconnectedEvent event) {
//     print('[ APPDEBUG ] ConferenceRoom._onDisconnected');
//   }

//   void onReconnecting(RoomReconnectingEvent room) {
//     print('[ APPDEBUG ] ConferenceRoom._onReconnecting');
//   }

//   void onConnectFailure(RoomConnectFailureEvent event) {
//     print('[ APPDEBUG ] ConferenceRoom._onConnectFailure: ${event.exception}');
//   }

//   void onParticipantConnected(RoomParticipantConnectedEvent event) {
//     print(
//         '[ APPDEBUG ] ConferenceRoom._onParticipantConnected, ${event.remoteParticipant.sid}');
//     addRemoteParticipantListeners(event.remoteParticipant);
//   }

//   void onParticipantDisconnected(RoomParticipantDisconnectedEvent event) {
//     print(
//         '[ APPDEBUG ] ConferenceRoom._onParticipantDisconnected: ${event.remoteParticipant.sid}');
//     _participants.removeWhere(
//         (ParticipantWidget p) => p.id == event.remoteParticipant.sid);
//   }

//   void addRemoteParticipantListeners(RemoteParticipant remoteParticipant) {
//     streamSubscriptions.add(remoteParticipant.onVideoTrackSubscribed
//         .listen(addOrUpdateParticipant));
//     streamSubscriptions.add(remoteParticipant.onAudioTrackSubscribed
//         .listen(addOrUpdateParticipant));
//   }

//   void addOrUpdateParticipant(RemoteParticipantEvent event) {
//     print(
//         '[ APPDEBUG ] ConferenceRoom._addOrUpdateParticipant(), ${event.remoteParticipant.sid}');
//     final participant = _participants.firstWhereOrNull(
//       (ParticipantWidget participant) =>
//           participant.id == event.remoteParticipant.sid,
//     );

//     if (participant != null) {
//       print(
//           '[ APPDEBUG ] Participant found: ${participant.id}, updating A/V enabled values');
//     } else {
//       if (event is RemoteVideoTrackSubscriptionEvent) {
//         print(
//             '[ APPDEBUG ] New participant, adding: ${event.remoteParticipant.sid}');
//         _participants.insert(
//           0,
//           buildParticipant(
//             child: event.remoteVideoTrack.widget(),
//             id: event.remoteParticipant.sid,
//           ),
//         );
//       }
//     }
//   }
// }
