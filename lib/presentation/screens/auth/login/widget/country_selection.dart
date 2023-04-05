import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../bloc/Auth_cubit/auth_cubit.dart';
import '../../model/country.dart';

class CountrySelectionDropDown extends StatefulWidget {
  final String text;
  final Color? fillColor;
  final Color? borderColor;
  const CountrySelectionDropDown(
      {Key? key, required this.text, this.fillColor, this.borderColor})
      : super(key: key);

  @override
  State<CountrySelectionDropDown> createState() =>
      _CountrySelectionDropDownState();
}

class _CountrySelectionDropDownState extends State<CountrySelectionDropDown> {
  Country? _chosenValue;

  @override
  void initState() {
    _chosenValue = null;
    GetIt.I<AuthCubit>().getcountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      bloc: GetIt.I<AuthCubit>(),
      builder: (context, state) {
        return (GetIt.I<AuthCubit>().countryModel != null &&
                GetIt.I<AuthCubit>().countryModel!.data!.isNotEmpty)
            ? SizedBox(
                height: screenHeight(context) * 0.085,
                child: DropdownButtonFormField(
                  isDense: true,
                  isExpanded: true,
                  icon: Visibility(
                    visible: false,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: colorGrey,
                      size: 30,
                    ),
                  ),
                  iconEnabledColor: const Color.fromRGBO(148, 148, 148, 1),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: colorGrey,
                      size: 30,
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: colorGrey.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: colorGrey.withOpacity(0.2),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: colorGrey.withOpacity(0.2),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: colorGrey.withOpacity(0.2),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: colorGrey.withOpacity(0.2),
                      ),
                    ),
                  ),
                  value: _chosenValue,
                  items: GetIt.I<AuthCubit>()
                      .countryModel!
                      .data!
                      .map<DropdownMenuItem<Country>>((Country value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.name ?? "",
                        style: headingStyle.copyWith(
                            color: colordeepGrey, fontSize: 12),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    widget.text,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: headingStyle.copyWith(
                        color: colorGrey,
                        fontSize: screenWidth(context) * 0.03),
                  ),
                  onChanged: (Country? value) {
                    setState(() {
                      _chosenValue = value;
                    });
                    prefs.setString(
                        "country_code", _chosenValue!.code.toString());
                    prefs.setInt("countryId", _chosenValue!.id!);
                    prefs.setString("country_name", value!.name!);
                    prefs.setString(
                        "currency", _chosenValue!.currencyCode.toString());
                    prefs.setString(
                        "phone_num", _chosenValue!.countNum.toString());
                    _chosenValue = value;
                  },
                ),
              )
            : const SizedBox();
      },
    );
  }
}
