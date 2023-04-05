import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class MyMessages extends StatefulWidget {
  final String message;
  const MyMessages({super.key, required this.message});

  @override
  State<MyMessages> createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: CircleAvatar(
            //     radius: 20,
            //     backgroundImage: NetworkImage(
            //       "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1654505109~exp=1654505709~hmac=c900df78283422aec0ce091154f5ff0d6098aff676d8529985829a92b1dedb31&w=360",
            //     ),
            //   ),
            // ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: kMainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                widget.message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
