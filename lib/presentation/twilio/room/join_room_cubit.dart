// ignore_for_file: avoid_print

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../../core/constants/constants.dart';
// import '../../../core/network/twilio_video_services.dart';

// abstract class RoomState extends Equatable {
//   const RoomState();
//   @override
//   List<Object> get props => [];
// }

// class RoomInitial extends RoomState {}

// class RoomError extends RoomState {
//   final String error;
//   const RoomError({required this.error});
//   @override
//   List<Object> get props => [error];
// }

// class RoomLoaded extends RoomState {
//   final String name;
//   final String token;
//   final String identity;

//   const RoomLoaded(
//       {required this.name, required this.token, required this.identity});
//   @override
//   List<Object> get props => [];
// }

// class RoomLoading extends RoomState {}

// class RoomCubit extends Cubit<RoomState> {
//   final TwilioFunctionsService backendService;

//   String? name;
//   RoomCubit({required this.backendService}) : super(RoomInitial());

//   submit() async {
//     emit(RoomLoading());
//     try {
//       if (name != null) {
//         final twilioRoomTokenResponse = await backendService.createToken(name!);
//         prefs.setString(
//             "video_call", twilioRoomTokenResponse['accessToken'].toString());
//         print(twilioRoomTokenResponse['user']);
//         prefs.setString("identity", twilioRoomTokenResponse['user'].toString());
//       }

//       if (prefs.getString("video_call") != null &&
//           prefs.getString("identity") != null) {
//         emit(RoomLoaded(
//             name: name ?? '',
//             token: prefs.getString("video_call").toString(),
//             identity: prefs.getString("identity").toString()));
//       } else {
//         emit(const RoomError(error: 'Access token is empty!'));
//       }
//     } catch (e) {
//       emit(const RoomError(
//           error: 'Something wrong happened when getting the access token'));
//     } finally {}
//   }
// }
