import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/widgets/custom_buttons_widget.dart';
import 'package:zat/core/widgets/custom_drop_down.dart';
import 'package:zat/core/widgets/custom_text_field.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/generator/locale_keys.dart';
import 'package:zat/presentation/screens/auth/bloc/Auth_cubit/auth_cubit.dart';
import 'package:zat/presentation/screens/auth/login/widget/country_selection.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/myaccount/widget/language_selection.dart';
import 'package:zat/presentation/screens/myaccount/widget/select_credits.dart';
import 'package:zat/presentation/screens/myaccount/widget/specialicity_selection.dart';
import 'package:zat/presentation/widget/profile_form_item.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/helper/validation.dart';
import '../../../../core/router/router.dart';
import '../../layout/layuot.dart';

class TutorProfileForm extends StatefulWidget {
  const TutorProfileForm({Key? key}) : super(key: key);

  @override
  State<TutorProfileForm> createState() => _TutorProfileFormState();
}

class _TutorProfileFormState extends State<TutorProfileForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController birthDatecontroller = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController bankCountry = TextEditingController();
  TextEditingController iban = TextEditingController();
  TextEditingController swiftcode = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController cv = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int? selected;
  File? imageFile;
  File? videoFile;
  String? imagePath;
  String? videoPath;
  String? filePathApi;
  List<String> selectionGender = [
    LocaleKeys.MALE.tr(),
    LocaleKeys.FEMALE.tr(),
  ];
  int? gender;

  List<String> positions = [
    translateString("Mr.", "استاذ", ""),
    translateString("doctor", "دكتور", ""),
  ];
  List<String> sp = [];
  Map<String, int> spId = {};
  Map<String, int> creditsId = {};
  Map<String, int> langId = {};
  List<String> lang = [];
  List<String> credits = [];
  @override
  void initState() {
    sp.clear();
    lang.clear();
    credits.clear();
    spId.clear();
    langId.clear();
    creditsId.clear();
    LanguageSelection.rateApi.clear();
    if (GetIt.I<ProfileCubit>().tutorProfileModel != null) {
      if (GetIt.I<ProfileCubit>()
          .tutorProfileModel!
          .data!
          .specialties!
          .isNotEmpty) {
        for (var element
            in GetIt.I<ProfileCubit>().tutorProfileModel!.data!.specialties!) {
          setState(() {
            sp.add(element.name!);
            spId.addAll({element.name!: element.id!});
          });
        }
      }

      if (GetIt.I<ProfileCubit>()
          .tutorProfileModel!
          .data!
          .credits!
          .isNotEmpty) {
        for (var element
            in GetIt.I<ProfileCubit>().tutorProfileModel!.data!.credits!) {
          setState(() {
            credits.add(element.name!);
            creditsId.addAll({element.name!: element.id!});
          });
        }
      }
      if (GetIt.I<ProfileCubit>()
          .tutorProfileModel!
          .data!
          .languages!
          .isNotEmpty) {
        for (var element
            in GetIt.I<ProfileCubit>().tutorProfileModel!.data!.languages!) {
          setState(() {
            lang.add(element.name!);
            langId.addAll({element.name!: element.id!});
          });
        }
      }
      cv.text = GetIt.I<ProfileCubit>().tutorProfileModel!.data!.cv ?? "";
      bio.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.tutorBio ?? "";
      phone.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.mobile ?? "";
      name.text = GetIt.I<ProfileCubit>().tutorProfileModel!.data!.name ?? "";
      email.text = GetIt.I<ProfileCubit>().tutorProfileModel!.data!.email ?? "";
      bankCountry.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.countryBankName ??
              "";
      bankname.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.bankName ?? "";
      swiftcode.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.swiftCode ?? "";
      iban.text = GetIt.I<ProfileCubit>().tutorProfileModel!.data!.ipan ?? "";
      accountNumber.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.accountNo ?? "";
      videoController.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.video ?? "";
      birthDatecontroller.text =
          GetIt.I<ProfileCubit>().tutorProfileModel!.data!.birthday ?? "";
    }
    LanguageSelection.languageApi.clear();
    SelectCreditsItem.creditsApi.clear();
    SpecialicitySelection.specialicityApi.clear();
    SelectCreditsItem.filePathApi.clear();
    chosenValue = null;
    selectedPosition = null;

    super.initState();
  }

  Future uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowedExtensions: ['txt', 'pdf', 'doc', 'zip'],
    );
    if (result != null) {
      setState(() {
        filePathApi = result.files.first.path;
      });

      showToast(
          msg: translateString("File uploaded successfully", "تم تحميل الملف ",
              "dosya başarıyla yüklendi"),
          state: ToastStates.SUCCESS);
    } else {
      showToast(
          msg: translateString(
              "There is an error please try again",
              "حدث خطأ اثناء تحميل الملف",
              "Bir hata oluştu lütfen tekrar deneyiniz"),
          state: ToastStates.ERROR);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileTutorSuccessState) {
          dialog(context);
          GetIt.I<ProfileCubit>().getUserProfile().then(
                (value) => MagicRouter.navigateAndPopAll(
                  const LayoutScreen(
                    index: 3,
                  ),
                ),
              );
        }
      },
      bloc: GetIt.I<ProfileCubit>(),
      builder: (context, state) {
        return (GetIt.I<ProfileCubit>().tutorProfileModel != null)
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context) * 0.02,
                  horizontal: screenWidth(context) * 0.04,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async => await getImage(),
                        child: (imageFile != null)
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: screenWidth(context) * 0.08,
                                backgroundImage: FileImage(imageFile!),
                              )
                            : (GetIt.I<ProfileCubit>()
                                            .tutorProfileModel!
                                            .data!
                                            .image !=
                                        null &&
                                    GetIt.I<ProfileCubit>()
                                            .tutorProfileModel!
                                            .data!
                                            .image !=
                                        "")
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: screenWidth(context) * 0.08,
                                    backgroundImage: NetworkImage(
                                        GetIt.I<ProfileCubit>()
                                            .tutorProfileModel!
                                            .data!
                                            .image!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: colorGrey,
                                    radius: screenWidth(context) * 0.08,
                                    child: const Center(
                                      child: Icon(
                                        CupertinoIcons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                      ),
                      const VerticalSpace(value: 2),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: LocaleKeys.GENDER.tr(),
                                style: headingStyle.copyWith(
                                  color: colordeepGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth(context) * 0.03,
                                )),
                            TextSpan(
                                text: "* ",
                                style: headingStyle.copyWith(
                                  color: kMainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth(context) * 0.03,
                                )),
                          ],
                        ),
                      ),
                      const VerticalSpace(value: 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          selectionGender.length,
                          (index) => SizedBox(
                            width: screenWidth(context) * 0.4,
                            child: RadioListTile(
                              value: index,
                              title: Text(
                                selectionGender[index],
                                style: headingStyle.copyWith(
                                  color: Colors.black87,
                                  fontSize: screenWidth(context) * 0.035,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              activeColor: colorBetrolly,
                              groupValue: (selected != null)
                                  ? selected
                                  : (GetIt.I<ProfileCubit>()
                                              .tutorProfileModel!
                                              .data!
                                              .gender ==
                                          "1")
                                      ? 0
                                      : (GetIt.I<ProfileCubit>()
                                                  .tutorProfileModel!
                                                  .data!
                                                  .gender ==
                                              "2")
                                          ? 1
                                          : selected,
                              onChanged: (int? value) {
                                setState(() {
                                  selected = value;
                                });
                                if (index == 0) {
                                  setState(() {
                                    gender = 1;
                                  });
                                } else {
                                  setState(() {
                                    gender = 2;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.NAME.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: name,
                          inputType: TextInputType.name,
                          // validator: (value) => validateName(value!),
                          hint: GetIt.I<ProfileCubit>()
                              .tutorProfileModel!
                              .data!
                              .name!,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.EMAIL.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: email,
                          inputType: TextInputType.emailAddress,
                          // validator: (value) => validateEmail(value!),
                          hint: GetIt.I<ProfileCubit>()
                              .tutorProfileModel!
                              .data!
                              .email!,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.PHONE.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: phone,
                          inputType: TextInputType.phone,
                          // validator: (value) => validate(value!),
                          hint: GetIt.I<ProfileCubit>()
                              .tutorProfileModel!
                              .data!
                              .mobile!,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        translateString(
                            "upload video", "تحميل فيديو", "video yükle"),
                        style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(context) * 0.03,
                        ),
                      ),
                      CustomTextFormField(
                        readOnly: true,
                        controller: videoController,
                        hint: (videoPath != null)
                            ? videoPath!
                            : (GetIt.I<ProfileCubit>()
                                        .tutorProfileModel!
                                        .data!
                                        .video !=
                                    "")
                                ? GetIt.I<ProfileCubit>()
                                    .tutorProfileModel!
                                    .data!
                                    .video!
                                : "",
                        ontap: () async => await getVidoe(),
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        translateString("CV", "السيرة الذاتية", "Özgeçmiş"),
                        style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(context) * 0.03,
                        ),
                      ),
                      CustomTextFormField(
                        maxLines: 5,
                        controller: cv,
                        hint: "",
                        validator: (value) => validate(value!),
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        translateString("Bio", "نبذه", ""),
                        style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(context) * 0.03,
                        ),
                      ),
                      CustomTextFormField(
                        controller: bio,
                        hint: "",
                        validator: (value) => validate(value!),
                      ),
                      const VerticalSpace(value: 2),
                      SpecialicitySelection(
                        specialicitiesId: spId,
                        specialicities: (GetIt.I<ProfileCubit>()
                                .tutorProfileModel!
                                .data!
                                .specialties!
                                .isNotEmpty)
                            ? sp
                            : [],
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        translateString(
                            "select position", "اختر الصفة", "pozisyon seç"),
                        style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(context) * 0.03,
                        ),
                      ),
                      CustomDropDown(
                          items: positions,
                          text: (GetIt.I<ProfileCubit>()
                                          .tutorProfileModel!
                                          .data!
                                          .position ==
                                      "Dr." ||
                                  GetIt.I<ProfileCubit>()
                                          .tutorProfileModel!
                                          .data!
                                          .position ==
                                      "د.")
                              ? translateString("Doctor", "دكتور", "")
                              : (GetIt.I<ProfileCubit>()
                                              .tutorProfileModel!
                                              .data!
                                              .position ==
                                          "Mr." ||
                                      GetIt.I<ProfileCubit>()
                                              .tutorProfileModel!
                                              .data!
                                              .position ==
                                          "أ.")
                                  ? translateString("MR.", "استاذ", "")
                                  : translateString("select position",
                                      "اختر الصفة", "pozisyon seç")),
                      const VerticalSpace(value: 2),
                      CustomTextFormField(
                        ontap: () async => await uploadFile(),
                        hint: (filePathApi != null)
                            ? filePathApi
                            : translateString(
                                "Position File", "الملفات", "Position File"),
                        readOnly: true,
                      ),
                      const VerticalSpace(value: 2),
                      SelectCreditsItem(
                        credits: credits,
                        creditsId: creditsId,
                      ),
                      const VerticalSpace(value: 2),
                      LanguageSelection(
                        languages: lang,
                        languageId: langId,
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        translateString("Bank account : ", "الحساب البنكي : ",
                            "Banka hesabı : "),
                        style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontSize: screenWidth(context) * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      CustomTextFormField(
                        hint: GetIt.I<ProfileCubit>()
                                .tutorProfileModel!
                                .data!
                                .bankName ??
                            translateString("bank name", "اسم البنك", ""),
                        controller: bankname,
                        inputType: TextInputType.text,
                      ),
                      const VerticalSpace(value: 2),
                      CustomTextFormField(
                        hint: GetIt.I<ProfileCubit>()
                                .tutorProfileModel!
                                .data!
                                .countryBankName ??
                            translateString("bank country", "دولة البنك", ""),
                        controller: bankCountry,
                        inputType: TextInputType.text,
                      ),
                      const VerticalSpace(value: 2),
                      CustomTextFormField(
                        hint: GetIt.I<ProfileCubit>()
                                .tutorProfileModel!
                                .data!
                                .accountNo ??
                            translateString("account number", "رقم الحساب", ""),
                        controller: accountNumber,
                        inputType: TextInputType.text,
                      ),
                      const VerticalSpace(value: 2),
                      CustomTextFormField(
                        hint: GetIt.I<ProfileCubit>()
                                .tutorProfileModel!
                                .data!
                                .ipan ??
                            translateString("ipan", "الإيبان", ""),
                        controller: iban,
                        inputType: TextInputType.text,
                      ),
                      const VerticalSpace(value: 2),
                      CustomTextFormField(
                        hint: GetIt.I<ProfileCubit>()
                                .tutorProfileModel!
                                .data!
                                .swiftCode ??
                            translateString("swift code", "سويفت كود", ""),
                        controller: swiftcode,
                        inputType: TextInputType.text,
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.COUNTRY.tr(),
                        isRequired: false,
                        widget: CountrySelectionDropDown(
                          text: prefs.getString('country_name') ??
                              LocaleKeys.COUNTRY.tr(),
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.BIRTH_DATE.tr(),
                        isRequired: false,
                        widget: CustomTextFormField(
                          controller: birthDatecontroller,
                          hint: "",
                          inputType: TextInputType.text,
                          readOnly: true,
                          ontap: () => selectDate(context),
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.PASSWORD.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: password,
                          inputType: TextInputType.text,
                          isPassword: true,
                          // validator: (value) => validatePassword(value!),
                          hint: "",
                        ),
                      ),
                      const VerticalSpace(value: 2),
                      ProfileFormItem(
                        title: LocaleKeys.VERIFY_PASSWORD.tr(),
                        isRequired: true,
                        widget: CustomTextFormField(
                          controller: confirmpassword,
                          isPassword: true,
                          inputType: TextInputType.text,
                          // validator: (value) => validateConfirmPassword(
                          //     value!, password.text),
                          hint: "",
                        ),
                      ),
                      const VerticalSpace(value: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          (state is! UpdateProfileTutorLoadingState)
                              ? SizedBox(
                                  width: screenWidth(context) * 0.25,
                                  height: screenHeight(context) * 0.04,
                                  child: CustomGeneralButton(
                                    text: LocaleKeys.UPDATE.tr(),
                                    textColor: Colors.white,
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        if (prefs.getInt("countryId") != null) {
                                          GetIt.I<ProfileCubit>()
                                              .postUpdatetutorProfile(
                                            bio: bio.text,
                                            rate: LanguageSelection.rateApi,
                                            position: (selectedPosition != null)
                                                ? selectedPosition!
                                                : GetIt.I<ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .position ??
                                                    "",
                                            bankCountry:
                                                (bankCountry.text.isNotEmpty)
                                                    ? bankCountry.text
                                                    : GetIt.I<ProfileCubit>()
                                                            .tutorProfileModel!
                                                            .data!
                                                            .countryBankName ??
                                                        "",
                                            bankname: (bankname.text.isNotEmpty)
                                                ? bankname.text
                                                : GetIt.I<ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .bankName ??
                                                    "",
                                            iban: (iban.text.isNotEmpty)
                                                ? iban.text
                                                : GetIt.I<ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .ipan ??
                                                    "",
                                            accountNumber:
                                                (accountNumber.text.isNotEmpty)
                                                    ? accountNumber.text
                                                    : GetIt.I<ProfileCubit>()
                                                            .tutorProfileModel!
                                                            .data!
                                                            .accountNo ??
                                                        "",
                                            swiftcode:
                                                (swiftcode.text.isNotEmpty)
                                                    ? swiftcode.text
                                                    : GetIt.I<ProfileCubit>()
                                                            .tutorProfileModel!
                                                            .data!
                                                            .swiftCode ??
                                                        "",
                                            positionFile: (filePathApi != null)
                                                ? MultipartFile.fromFileSync(
                                                    filePathApi!)
                                                : "",
                                            credits:
                                                SelectCreditsItem.creditsApi,
                                            name: (name.text.isEmpty)
                                                ? GetIt.I<ProfileCubit>()
                                                    .tutorProfileModel!
                                                    .data!
                                                    .name!
                                                : name.text,
                                            password: password.text,
                                            phone: (phone.text.isEmpty)
                                                ? GetIt.I<ProfileCubit>()
                                                    .tutorProfileModel!
                                                    .data!
                                                    .mobile!
                                                : phone.text,
                                            gender: (gender != null)
                                                ? gender!
                                                : int.parse(
                                                    GetIt.I<ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .gender!),
                                            birthdate: (birthDatecontroller
                                                    .text.isNotEmpty)
                                                ? birthDatecontroller.text
                                                : "",
                                            email: (email.text.isEmpty)
                                                ? GetIt.I<ProfileCubit>()
                                                    .tutorProfileModel!
                                                    .data!
                                                    .email!
                                                : email.text,
                                            cv: (cv.text.isNotEmpty)
                                                ? cv.text
                                                : GetIt.I<ProfileCubit>()
                                                        .tutorProfileModel!
                                                        .data!
                                                        .cv ??
                                                    "",
                                            image: (imagePath != null)
                                                ? MultipartFile.fromFileSync(
                                                    imagePath!)
                                                : "",
                                            language:
                                                LanguageSelection.languageApi,
                                            specialicity: SpecialicitySelection
                                                .specialicityApi,
                                            video: (videoPath != null)
                                                ? MultipartFile.fromFileSync(
                                                    videoPath!)
                                                : "",
                                          );
                                        } else {
                                          showToast(
                                              msg: translateString(
                                                  "you must select country",
                                                  "يجب اختيار الدولة",
                                                  ""),
                                              state: ToastStates.ERROR);
                                        }
                                      }
                                    },
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: kMainColor,
                                  ),
                                ),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {},
                            bloc: GetIt.I<AuthCubit>(),
                            builder: (context, state) {
                              return TextButton(
                                  onPressed: () {
                                    GetIt.I<AuthCubit>().postDeleteAccount();
                                  },
                                  child: Text(
                                    LocaleKeys.DELETE_ACCOUNT.tr(),
                                    style: headingStyle.copyWith(
                                      color: kMainColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : loading();
      },
    );
  }

  ///////////////////////////////////////////////////////
  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1880, 8),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDatecontroller.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  /////////////////////////////////////////////////////////////

  Future<void> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      setState(() {
        imagePath = result.files.first.path;
        imageFile = File(result.files.first.path!);
      });
    } else {}
  }

  ///////////////////////////////////////////////////////
  Future<void> getVidoe() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      setState(() {
        videoFile = File(result.files.first.path!);
        videoPath = result.files.first.path;
      });
    }
  }
}
