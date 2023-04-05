// // ignore_for_file: avoid_print, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:get_it/get_it.dart';
// import 'package:zat/core/router/router.dart';
// import 'package:zat/presentation/screens/layout/layuot.dart';

// import '../../../../core/constants/colors.dart';
// import '../cubit/quastionaire_cubit.dart';

// class PaymentGatway extends StatefulWidget {
//   final String url;
//   final int? id;
//   final bool fromQuastionare;
//   const PaymentGatway({
//     Key? key,
//     required this.url,
//     this.id,
//     required this.fromQuastionare,
//   }) : super(key: key);

//   @override
//   _PaymentGatwayState createState() => _PaymentGatwayState();
// }

// class _PaymentGatwayState extends State<PaymentGatway> {
//   final flutterWebviewPlugin = FlutterWebviewPlugin();

//   String? status;

//   @override
//   void initState() {
//     super.initState();
//     flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       var uri = Uri.parse(url);
//       uri.queryParameters.forEach((k, v) {
//         print('key: $k - value: $v');
//         if (k == "status") {
//           setState(() {
//             status = v;
//           });
//         }
//       });
//       print(status);
//       if (status != null) {
//         if (status == "paid") {
//           if (widget.fromQuastionare == true) {
//             GetIt.I<QuastionaireCubit>().getQuestions(widget.id);
//           } else {
//             MagicRouter.navigateAndPopAll(const LayoutScreen());
//           }
//           flutterWebviewPlugin.close();
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flutterWebviewPlugin.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: WebviewScaffold(
//         appBar: AppBar(
//           leading: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: colordeepGrey,
//             ),
//           ),
//           automaticallyImplyLeading: false,
//           elevation: 0.0,
//           backgroundColor: Colors.white,
//         ),
//         url: widget.url,
//         withJavascript: true,
//         mediaPlaybackRequiresUserGesture: true,
//         debuggingEnabled: false,
//         resizeToAvoidBottomInset: true,
//       ),
//     );
//   }
// }
