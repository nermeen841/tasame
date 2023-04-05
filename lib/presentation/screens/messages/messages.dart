import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

import 'widget/chat_list.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight(context) * 0.05,
            child: CustomTextFormField(
              hint: translateString(
                  "Search in Contacts", "بحث في جهات الاتصال", "Kişilerde Ara"),
              prefix: const Icon(
                CupertinoIcons.search,
                color: Colors.black,
              ),
            ),
          ),
          const VerticalSpace(value: 3),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 0.05,
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.CHAT_TITLE.tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth(context) * 0.04,
                    ),
                  ),
                ),
              ),
              const VerticalSpace(value: 1),
              //     SizedBox(
              //       width: screenWidth(context) * 0.35,
              //       height: screenHeight(context) * 0.04,
              //       child: CustomGeneralButton(
              //         text: LocaleKeys.SEE_PLANS.tr(),
              //         color: Colors.transparent,
              //         borderColor: colorRed,
              //         textColor: colorRed,
              //         onTap: () =>
              //             MagicRouter.navigateTo(const PlansAndPricesScreen()),
              //       ),
              //     ),
              const VerticalSpace(value: 2),
              const ChatList(),
            ],
          ),
        ],
      ),
    );
  }
}
