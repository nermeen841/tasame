import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.isPassword,
    this.inputType,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.onEditingComplete,
    this.maxLines,
    this.label,
    this.controller,
    this.suffix,
    this.suffixPressed,
    this.prefix,
    this.hint,
    this.validator,
    this.isLTR,
    this.readOnly,
    this.ontap,
  }) : super(key: key);
  final TextEditingController? controller;

  final TextInputType? inputType;
  final ValueSetter? onChanged;
  final ValueSetter? onSaved;
  final FocusNode? focusNode;
  final int? maxLines;
  final String? label;
  final String? hint;
  final bool? isPassword;
  final bool? readOnly;
  final VoidCallback? ontap;
  final IconData? suffix;
  final Widget? prefix;
  final bool? isLTR;
  final FormFieldValidator<String>? validator;
  final Function()? onEditingComplete;
  final Function? suffixPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: isLTR == true ? TextDirection.ltr : null,
      validator: validator,
      readOnly: readOnly ?? false,
      onTap: ontap,
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword ?? false,
      keyboardType: inputType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      onEditingComplete: onEditingComplete,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        // labelStyle: headingStyle.copyWith(color: kMainColor),
        hintText: hint,
        hintStyle: headingStyle.copyWith(color: colorLightGrey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorBetrolly),
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix))
            : null,
        prefixIcon: prefix,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorGreyLight.withOpacity(0.4)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorGreyLight.withOpacity(0.4)),
        ),
      ),
    );
  }
}
