// ignore_for_file: list_remove_unrelated_type, iterable_contains_unrelated_type

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';

class SelectCreditsItem extends StatefulWidget {
  static List<int> creditsApi = [];
  static List<dynamic> filePathApi = [];
  final List<String> credits;
  final Map<String, int> creditsId;
  const SelectCreditsItem(
      {super.key, required this.credits, required this.creditsId});

  @override
  State<SelectCreditsItem> createState() => _SelectCreditsItemState();
}

class _SelectCreditsItemState extends State<SelectCreditsItem> {
  List<bool> selectedCredits = [];

  @override
  void initState() {
    GetIt.I<ProfileCubit>().getAllCredits().then((value) {
      if (GetIt.I<ProfileCubit>().creidtsModel != null &&
          GetIt.I<ProfileCubit>().creidtsModel!.data!.isNotEmpty) {
        selectedCredits = List<bool>.generate(
            GetIt.I<ProfileCubit>().creidtsModel!.data!.length, (index) {
          if (widget.credits.isNotEmpty) {
            if (widget.credits.contains(
                GetIt.I<ProfileCubit>().creidtsModel!.data![index].name)) {
              setState(() {
                selectedCredits.add(true);
                SelectCreditsItem.creditsApi.add(
                    GetIt.I<ProfileCubit>().creidtsModel!.data![index].id!);
              });
              return true;
            } else {
              setState(() {
                selectedCredits.add(false);
                SelectCreditsItem.creditsApi.remove(
                    GetIt.I<ProfileCubit>().creidtsModel!.data![index].id!);
              });
              return false;
            }
          } else {
            selectedCredits.add(false);
            SelectCreditsItem.creditsApi.clear();
            return false;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: translateString(
                      "select Credit", "اختر الاعتماد", "kredi seç"),
                  style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(context) * 0.03,
                  )),
              TextSpan(
                  text: "*",
                  style: headingStyle.copyWith(
                    color: kMainColor,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(context) * 0.03,
                  )),
            ],
          ),
        ),
        BlocConsumer<ProfileCubit, ProfileState>(
          bloc: GetIt.I<ProfileCubit>(),
          listener: (context, state) {},
          builder: (context, state) => (GetIt.I<ProfileCubit>().creidtsModel !=
                  null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    GetIt.I<ProfileCubit>().creidtsModel!.data!.length,
                    (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: (selectedCredits.isNotEmpty)
                                  ? selectedCredits[index]
                                  : false,
                              onChanged: (value) {
                                if (widget.creditsId.isNotEmpty) {
                                  GetIt.I<ProfileCubit>().deleteCredits(
                                      widget.creditsId[GetIt.I<ProfileCubit>()
                                              .creidtsModel!
                                              .data![index]
                                              .name!] ??
                                          0);
                                }
                                setState(() {
                                  selectedCredits[index] = value!;
                                });
                                if (SelectCreditsItem.creditsApi.contains(
                                    GetIt.I<ProfileCubit>()
                                        .creidtsModel!
                                        .data![index]
                                        .id!)) {
                                  setState(() {
                                    SelectCreditsItem.creditsApi.remove(
                                        GetIt.I<ProfileCubit>()
                                            .creidtsModel!
                                            .data![index]
                                            .id!);
                                  });
                                } else {
                                  setState(() {
                                    SelectCreditsItem.creditsApi.add(
                                        GetIt.I<ProfileCubit>()
                                            .creidtsModel!
                                            .data![index]
                                            .id!);
                                  });
                                }
                              },
                            ),
                            Text(
                              GetIt.I<ProfileCubit>()
                                      .creidtsModel!
                                      .data![index]
                                      .name ??
                                  "",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: headingStyle.copyWith(
                                color: colordeepGrey,
                                fontSize: screenWidth(context) * 0.035,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        BlocConsumer<ProfileCubit, ProfileState>(
                          listener: (context, state) {},
                          bloc: GetIt.I<ProfileCubit>(),
                          builder: (context, state) {
                            return (state is! UploadCreditsFilesLoadingState)
                                ? SizedBox(
                                    width: screenWidth(context) * 0.2,
                                    height: screenHeight(context) * 0.045,
                                    child: CustomGeneralButton(
                                      color: kMainColor,
                                      borderColor: Colors.transparent,
                                      textColor: Colors.white,
                                      text: translateString(
                                          "upload", "تحميل", "yüklemek"),
                                      onTap: () async {
                                        await uploadFile().then(
                                          (value) => GetIt.I<ProfileCubit>()
                                              .uploadCreditsFlies(),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  Future uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (result != null) {
      for (var element in result.paths) {
        setState(() {
          SelectCreditsItem.filePathApi
              .add(MultipartFile.fromFileSync(element!));
        });
      }
    } else {
      showToast(
          msg: translateString(
              "There is an error please try again",
              "حدث خطأ اثناء تحميل الملف",
              "Bir hata oluştu lütfen tekrar deneyiniz"),
          state: ToastStates.ERROR);
    }
  }
}
