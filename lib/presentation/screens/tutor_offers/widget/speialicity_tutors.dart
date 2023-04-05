import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/myaccount/model/specialicity.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../widget/person_card.dart';
import '../../home/cubit/home_cubit.dart';

class TutorsSpecialicityList extends StatefulWidget {
  final List<Tutors> tutors;
  const TutorsSpecialicityList({Key? key, required this.tutors})
      : super(key: key);

  @override
  State<TutorsSpecialicityList> createState() => _TutorsSpecialicityListState();
}

class _TutorsSpecialicityListState extends State<TutorsSpecialicityList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      bloc: GetIt.I<HomeCubit>(),
      builder: (context, state) {
        return (widget.tutors.isNotEmpty)
            ? GridView.builder(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context) * 0.02,
                  horizontal: screenWidth(context) * 0.02,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) => PersonCard(
                  counsultantID: widget.tutors[index].id!,
                  name: widget.tutors[index].name!,
                  image: widget.tutors[index].image!,
                  rate: widget.tutors[index].rate!.toString(),
                  fromfavourite: widget.tutors[index].isFav ?? false,
                  lang: widget.tutors[index].languages!,
                ),
                itemCount: widget.tutors.length,
              )
            : Center(
                child: Text(
                  translateString("no consultant here", "لا يوجد مستشارين", ""),
                  style: headingStyle.copyWith(
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth(context) * 0.045,
                  ),
                ),
              );
      },
    );
  }
}
