import 'package:flutter/material.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import '../widget/payment_types.dart';

class PaymentTypeSelection extends StatefulWidget {
  final bool fromQuestions;
  final int? questionareId;
  final int? orderId;
  const PaymentTypeSelection(
      {Key? key, required this.fromQuestions, this.questionareId, this.orderId})
      : super(key: key);

  @override
  State<PaymentTypeSelection> createState() => _PaymentTypeSelectionState();
}

class _PaymentTypeSelectionState extends State<PaymentTypeSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "", context: context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.04,
          vertical: screenHeight(context) * 0.02,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context) * 0.02,
            vertical: screenHeight(context) * 0.02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth(context) * 0.02),
            boxShadow: [
              BoxShadow(
                color: colorGrey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: PaymentsMedthods(
            fromQuestions: widget.fromQuestions,
            quastionareId: widget.questionareId,
            orderId: widget.orderId,
          ),
        ),
      ),
    );
  }
}
