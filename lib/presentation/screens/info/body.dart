import 'package:flutter/material.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';

class InfoBody extends StatefulWidget {
  final String title;
  final String content;
  final String? image;

  const InfoBody(
      {Key? key, required this.title, required this.content, this.image})
      : super(key: key);

  @override
  State<InfoBody> createState() => _InfoBodyState();
}

class _InfoBodyState extends State<InfoBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight(context) * 0.02,
        horizontal: screenWidth(context) * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (widget.image != null)
              ? SizedBox(
                  width: double.infinity,
                  height: screenHeight(context) * 0.25,
                  child: customCachedNetworkImage(
                    url: widget.image!,
                    context: context,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
          (widget.image != null)
              ? const VerticalSpace(value: 4)
              : const SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                color: kMainColor,
                size: screenWidth(context) * 0.04,
              ),
              const HorizontalSpace(value: 1),
              SizedBox(
                width: screenWidth(context) * 0.85,
                child: Text(
                  widget.title,
                  style: headingStyle.copyWith(
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.04,
                  ),
                ),
              ),
            ],
          ),
          const VerticalSpace(value: 2),
          Wrap(
            children: [
              Text(
                parseHtmlString(widget.content),
                style: headingStyle.copyWith(
                  color: colordeepGrey,
                  height: 1.7,
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth(context) * 0.035,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
