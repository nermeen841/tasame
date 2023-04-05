import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/widgets/space_widget.dart';
import '../../widget/consult-list.dart';
import '../../widget/search_result.dart';
import '../home/cubit/home_cubit.dart';
import '../home/widget/filter-search.dart';

class BookConsultationScreen extends StatefulWidget {
  const BookConsultationScreen({Key? key}) : super(key: key);

  @override
  State<BookConsultationScreen> createState() => _BookConsultationScreenState();
}

class _BookConsultationScreenState extends State<BookConsultationScreen> {
  @override
  void initState() {
    isSearching = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => GetIt.I<HomeCubit>().getAllConsultant(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context) * 0.03,
            vertical: screenHeight(context) * 0.02),
        child: Column(
          children: [
            // const TimeSelectionForBooking(),
            const VerticalSpace(value: 3),
            (isSearching) ? const SearchResultData() : const ConultantList(),
            const VerticalSpace(value: 3),
          ],
        ),
      ),
    );
  }
}
