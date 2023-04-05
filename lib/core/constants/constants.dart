// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zat/core/constants/colors.dart';

const kLogo = 'asset/images/logo.png';
const kHomeLayout = '/';
TextStyle headingStyle = TextStyle(
  fontFamily: 'Tajawal',
  fontSize: 16,
  color: colordeepGrey,
);

//////////////////////////////////////////////////

Widget logoImage() {
  return Center(
    child: Image.asset(kLogo),
  );
}
//////////////////////////////////////////////////

appbarNoTitle() {
  return AppBar(
    toolbarHeight: 0.0,
    elevation: 0.0,
  );
}

/////////////////////////////////////////////////

late SharedPreferences prefs;

Future startShared() async {
  prefs = await SharedPreferences.getInstance();
}

//////////////////////////////////////////////////////////

String translateString(String english, String arabic, String turkey) {
  return prefs.getString("lang") == 'en'
      ? english
      : (prefs.getString("lang") == 'tr')
          ? turkey
          : arabic;
}

////////////////////////////////////////////////////////////

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

///////////////////////////////////////////////////////////

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

///////////////////////////////////////////////////////////
customAppbar({
  required String title,
  required context,
  VoidCallback? press,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: false,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: headingStyle.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: MediaQuery.of(context).size.width * 0.04),
    ),
    leading: InkWell(
      onTap: press ?? () => Navigator.pop(context),
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
  );
}

//////////////////////////////////////////////////////////////////////
customCachedNetworkImage({required String url, required context, BoxFit? fit}) {
  try {
    // ignore: unnecessary_null_comparison
    if (url == null || url == "") {
      return Image.asset(
        "asset/icons/app_logo.png",
        width: screenWidth(context) * 0.2,
        fit: BoxFit.contain,
      );
    } else {
      return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: (Uri.parse(url).isAbsolute)
            ? CachedNetworkImage(
                imageUrl: url,
                fit: fit,
                placeholder: (context, url) => Image.asset(
                      "asset/icons/app_logo.png",
                      width: screenWidth(context) * 0.2,
                      fit: BoxFit.contain,
                    ),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    "asset/icons/app_logo.png",
                    width: screenWidth(context) * 0.2,
                    fit: BoxFit.contain,
                  );
                })
            : Image.asset(
                "asset/icons/app_logo.png",
                width: screenWidth(context) * 0.2,
                fit: BoxFit.contain,
              ),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

///////////////////////////////////////////////////////////////////

Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      color: kMainColor,
    ),
  );
}

///////////////////////////////////////////////////////////////////

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}

////////////////////////////////////////////////////////////
homeBottomSheet({required BuildContext context, required Widget child}) {
  var w = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(w * 0.07),
          topLeft: Radius.circular(w * 0.07)),
    ),
    isDismissible: true,
    isScrollControlled: true,
    context: context,
    builder: (context) =>
        Padding(padding: MediaQuery.of(context).viewInsets, child: child),
  );
}
///////////////////////////////////////////////////////////////

String getPrice({required num price}) {
  if (prefs.getString("currency") == "SAR") {
    num finalPrice = price;
    return "${finalPrice.toStringAsFixed(2)} ${prefs.getString("currency")}";
  } else {
    num finalPrice = price * num.parse(prefs.getString("ratio").toString());
    return "${finalPrice.toStringAsFixed(2)} ${prefs.getString("currency")}";
  }
}

////////////////////////////////////////////////////////////////////////
translateOrderStatuse(String status) {
  if (status == "booked") {
    return translateString("booked", "تم الحجز", "");
  } else if (status == "closed") {
    return translateString("closed", "مغلق", "");
  } else if (status == "available") {
    return translateString("available", "متاح", "");
  }
}

//////////////////////////////////////////////////////////////////////////////
void dialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context),
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
          ),
        ),
        onWillPop: () async => false,
      );
    },
  );
}
