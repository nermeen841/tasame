// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';

String? chosenValue;
String? selectedPosition;

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {Key? key,
      this.items,
      this.text = '',
      this.fillColor = Colors.white,
      this.onSave,
      this.borderColor,
      this.validator})
      : super(key: key);
  final List<String>? items;
  final String text;
  final Color? fillColor;
  final Color? borderColor;
  final Function(String?)? onSave;
  final String? Function(String?)? validator;

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // List<String>? categories = widget.items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: (widget.borderColor == null)
            ? Border.all(color: colorGrey.withOpacity(0.2))
            : Border.all(color: widget.borderColor!),
        color: widget.fillColor!,
      ),
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: DropdownButtonFormField(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: colorGrey,
          size: 30,
        ),
        iconEnabledColor: const Color.fromRGBO(148, 148, 148, 1),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        value: chosenValue,
        items: widget.items?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: headingStyle.copyWith(color: colordeepGrey, fontSize: 12),
            ),
          );
        }).toList(),
        hint: Text(
          widget.text,
          style: headingStyle.copyWith(
              color: colorGrey, fontSize: screenWidth(context) * 0.03),
        ),
        onChanged: (String? value) {
          if (value == "استاذ" || value == "Mr.") {
            setState(() {
              selectedPosition = translateString("Mr.", "أ.", "");
              chosenValue = value;
            });
          } else if (value == "دكتور" || value == "doctor") {
            setState(() {
              selectedPosition = translateString("Dr.", "د.", "");
              chosenValue = value;
            });
          } else {
            setState(() {
              chosenValue = value;
            });
            chosenValue = value;
          }
          print(selectedPosition);
        },
        onSaved: widget.onSave,
        validator: widget.validator,
      ),
    );
  }
}
