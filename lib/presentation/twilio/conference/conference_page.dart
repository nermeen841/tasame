// ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:zat/core/constants/constants.dart';
// import 'package:zat/core/router/router.dart';
// import 'package:zat/presentation/screens/layout/layuot.dart';
// import 'cubit/conference_cubit_cubit.dart';

// class ConferencePage extends StatefulWidget {
//   // final String identity;
//   const ConferencePage({
//     Key? key,
//     // required this.identity,
//   }) : super(key: key);

//   @override
//   _ConferencePageState createState() => _ConferencePageState();
// }

// class _ConferencePageState extends State<ConferencePage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: BlocConsumer<ConferenceCubitCubit, ConferenceCubitState>(
//           listener: (context, state) {},
//           bloc: GetIt.I<ConferenceCubitCubit>(),
//           builder: (context, state) {
//             if (state is ConferenceInitial) {
//               return showProgress();
//             }
//             if (state is ConferenceLoaded) {
//               return Stack(
//                 alignment: AlignmentDirectional.bottomCenter,
//                 children: <Widget>[
//                   _buildParticipants(context),
//                   Align(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.call_end_sharp,
//                         color: Colors.red,
//                         size: screenWidth(context) * 0.1,
//                       ),
//                       onPressed: () async {
//                         GetIt.I<ConferenceCubitCubit>().disconnect().then(
//                           (value) {
//                             prefs.remove("video_call");
//                             MagicRouter.navigateAndPopAll(const LayoutScreen());
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return Container();
//           }),
//     );
//   }

//   Widget showProgress() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         Center(child: CircularProgressIndicator()),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           'Connecting to the room...',
//           style: TextStyle(color: Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildParticipants(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final children = <Widget>[];
//     _buildOverlayLayout(context, size, children);
//     return Stack(children: children);
//   }

//   void _buildOverlayLayout(
//       BuildContext context, Size size, List<Widget> children) {
//     children.add(
//       BlocConsumer<ConferenceCubitCubit, ConferenceCubitState>(
//         listener: (context, state) {},
//         bloc: GetIt.I<ConferenceCubitCubit>(),
//         builder: (context, state) {
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1),
//             itemCount: GetIt.I<ConferenceCubitCubit>().participants.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Card(
//                 child: GetIt.I<ConferenceCubitCubit>().participants[index],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
