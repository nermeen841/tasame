import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/space_widget.dart';

class TimePeroidSelection extends StatefulWidget {
  const TimePeroidSelection({Key? key}) : super(key: key);

  @override
  State<TimePeroidSelection> createState() => _TimePeroidSelectionState();
}

class _TimePeroidSelectionState extends State<TimePeroidSelection> {
  int? selected;
  bool isfirst = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenWidth(context) * 0.7,
        height: screenHeight(context) * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: colorGrey.withOpacity(0.2),
              offset: const Offset(0, 1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpace(value: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => Text(
                  "1 day",
                  style: headingStyle,
                ),
              ),
            ),
            const VerticalSpace(value: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => Radio(
                  value: index,
                  activeColor: kMainColor,
                  groupValue: selected,
                  onChanged: (int? value) {
                    setState(() {
                      selected = value;
                    });
                  },
                ),
              ),
            ),
            const VerticalSpace(value: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isfirst = false;
                    });
                  },
                  child: Container(
                    width: screenWidth(context) * 0.2,
                    height: screenHeight(context) * 0.07,
                    decoration: BoxDecoration(
                      color: (!isfirst)
                          ? kMainColor
                          : Colors.blueAccent.withOpacity(0.2),
                      border: Border.all(
                        color: colorGrey.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(
                        screenWidth(context) * 0.015,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "25 \n Minutes",
                          textAlign: TextAlign.center,
                          style: headingStyle.copyWith(
                            color: (!isfirst) ? Colors.white : colordeepGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const HorizontalSpace(value: 2),
                InkWell(
                  onTap: () {
                    setState(() {
                      isfirst = true;
                    });
                  },
                  child: Container(
                    width: screenWidth(context) * 0.2,
                    height: screenHeight(context) * 0.07,
                    decoration: BoxDecoration(
                      color: (isfirst)
                          ? kMainColor
                          : Colors.blueAccent.withOpacity(0.2),
                      border: Border.all(
                        color: colorGrey.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(
                        screenWidth(context) * 0.015,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "50 \n Minutes",
                          textAlign: TextAlign.center,
                          style: headingStyle.copyWith(
                            color: (isfirst) ? Colors.white : colordeepGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
