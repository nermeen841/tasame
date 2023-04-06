// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/myaccount/actions/add_new_appointment.dart';
import 'package:zat/presentation/screens/myaccount/actions/add_new_offer.dart';
import 'package:zat/presentation/screens/myaccount/actions/cancel_appointment.dart';
import 'package:zat/presentation/screens/myaccount/actions/delete_credits.dart';
import 'package:zat/presentation/screens/myaccount/actions/delete_offer.dart';
import 'package:zat/presentation/screens/myaccount/actions/delete_specialicity.dart';
import 'package:zat/presentation/screens/myaccount/actions/delete_tutor_appointment.dart';
import 'package:zat/presentation/screens/myaccount/actions/end_room.dart';
import 'package:zat/presentation/screens/myaccount/actions/get_creidts.dart';
import 'package:zat/presentation/screens/myaccount/actions/get_profile.dart';
import 'package:zat/presentation/screens/myaccount/actions/get_specialicity.dart';
import 'package:zat/presentation/screens/myaccount/actions/update_tutor_profile.dart';
import 'package:zat/presentation/screens/myaccount/actions/update_user_profile.dart';
import 'package:zat/presentation/screens/myaccount/actions/upload_creidts_file.dart';
import 'package:zat/presentation/screens/myaccount/model/credits.dart';
import 'package:zat/presentation/screens/myaccount/model/specialicity.dart';
import 'package:zat/presentation/screens/myaccount/model/tutuor_model.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../dashboard/consultant/pages/appointment/appointment.dart';
import '../actions/delete_language.dart';
import '../actions/edit_tutor_appointment.dart';
import '../widget/language_selection.dart';
import '../widget/select_credits.dart';
import '../widget/specialicity_selection.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserModel? userModel;
  TutorProfileModel? tutorProfileModel;
  Future getUserProfile() async {
    emit(GetProfileLoadingState());
    (prefs.getString("user_type") == "user")
        ? await GetUserProfileActions().run().then(
              (value) => value.fold(
                (l) {
                  print(l.message);
                  emit(GetProfileErrorState());
                },
                (r) {
                  userModel = r;
                  prefs.setString("user_id", r!.data!.id!.toString());
                  emit(GetProfileSuccessState());
                  return userModel;
                },
              ),
            )
        : await GetTutorProfileAction().run().then(
              (value) => value.fold(
                (l) {
                  print(l.message);
                  emit(GetProfileErrorState());
                },
                (r) {
                  tutorProfileModel = r;
                  prefs.setString("user_id", r!.data!.id!.toString());
                  emit(GetProfileSuccessState());
                  return userModel;
                },
              ),
            );
  }

  ////////////////////////////////////////////////////////////////////
  postEditUserProfile({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String birthdate,
    required int gender,
  }) async {
    emit(UpdateProfileLoadingState());
    await UpdateUserProfileActions(
            name, phone, email, password, birthdate, gender)
        .run()
        .then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(UpdateProfileErrorState());
            },
            (r) {
              userModel = r;
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(UpdateProfileSuccessState());
              return userModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////
  postAddNewOffer({
    required String numofConsultant,
    required String price,
  }) async {
    emit(AddNewOfferLoadingState());
    await AddNewOfferAction(numofConsultant, price).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(AddNewOfferErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(AddNewOfferSuccessState());
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////
  addNewAppointment({
    required String startDate,
    required String endDate,
    required String time,
  }) async {
    emit(AddNewAppointmentLoadingState());
    await AddNewAppointmnetAction(startDate, endDate, time).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(AddNewAppointmentErrorState());
              getUserProfile();
              MagicRouter.navigateAndPopAll(const LayoutScreen(
                index: 0,
              ));
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              getUserProfile();
              if (r.message !=
                  "لابد من وجود مده ساعة على الاقل بعد الموعد السابق لاضافة موعد جديد") {
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 0,
                ));
                // MagicRouter.navigateAndPReplacement(
                //     const ManageTutorAppointmentScreen());
              }
              emit(AddNewAppointmentSuccessState());
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////
  deleteOffer(offerID) async {
    emit(DeleteOfferLoadingState());
    await DeleteOfferAction(offerID).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(DeleteOfferErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(DeleteOfferSuccessState());
              // MagicRouter.pop();
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////
  postCancelAppointment(timeId) async {
    emit(CancelAppointmentLoadingState());
    await CancelAppointmentAction(timeId).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(CancelAppointmentErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              getUserProfile();
              emit(CancelAppointmentSuccessState());
              MagicRouter.navigateAndPopAll(const LayoutScreen(
                index: 0,
              ));
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////
  postEndRoom(timeId) async {
    emit(EndRoomLoadingState());
    await EndRoomAction(timeId).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(EndRoomErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(EndRoomSuccessState());
              MagicRouter.navigateAndPopAll(const LayoutScreen());
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////
  editTutorAppointment({
    required int timeId,
    required String availableHours,
  }) async {
    emit(EditAppointmentLoadingState());
    await EditTutorAppointmentAction(timeId, availableHours).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(EditAppointmentErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(EditAppointmentSuccessState());
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////////////////
  SpecialicityModel? specialicityModel;
  Future getSpecialicity() async {
    emit(GetSpecialicityLoadingState());
    await GetSpecialicityAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetSpecialicityErrorState());
            },
            (r) {
              specialicityModel = r;
              emit(GetSpecialicitySuccessState());
              return specialicityModel;
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////////
  deleteTutorAppointment(int timeId) async {
    emit(DeleteTutorAppointmentLoadingState());
    await DeleteTutorAppointmentAction(timeId).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(DeleteTutorAppointmentErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(DeleteTutorAppointmentSuccessState());
              MagicRouter.navigateAndPopAll(const LayoutScreen(
                index: 0,
              ));
              // MagicRouter.navigateAndPReplacement(
              //     const ManageTutorAppointmentScreen());
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////////////
  postUpdatetutorProfile({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String birthdate,
    required String cv,
    required String bio,
    required int gender,
    required List<int> specialicity,
    required List<int> language,
    required List<int> rate,
    required List<int> credits,
    required dynamic positionFile,
    required dynamic image,
    required dynamic video,
    required String bankname,
    required String bankCountry,
    required String iban,
    required String swiftcode,
    required String accountNumber,
    required String position,
  }) async {
    emit(UpdateProfileTutorLoadingState());
    await UpdateTutorProfileAction(
      accountNumber: accountNumber,
      bankCountry: bankCountry,
      rate: rate,
      bankname: bankname,
      birthdate: birthdate,
      swiftcode: swiftcode,
      credits: credits,
      cv: cv,
      email: email,
      gender: gender,
      iban: iban,
      image: image!,
      language: language,
      name: name,
      password: password,
      phone: phone,
      position: position,
      specialicity: specialicity,
      bio: bio,
    ).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              if (rate.isEmpty || language.length != rate.length) {
                showToast(
                    msg: translateString(
                        "rate must be selected for each language",
                        "يجب تحديد تقييم لكل لغة يتم اختيارها",
                        ""),
                    state: ToastStates.ERROR);
              } else {
                showToast(
                    msg: translateString(
                        "There is an error please try again later",
                        "حدث خطأ ما الرجاء المحاولة في وقت لاحق",
                        ""),
                    state: ToastStates.ERROR);
              }
              emit(UpdateProfileTutorErrorState());
            },
            (r) {
              LanguageSelection.languageApi.clear();
              LanguageSelection.rateApi.clear();
              SelectCreditsItem.creditsApi.clear();
              SpecialicitySelection.specialicityApi.clear();
              SelectCreditsItem.filePathApi.clear();
              chosenValue = null;
              selectedPosition = null;
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(UpdateProfileTutorSuccessState());
              // MagicRouter.navigateAndPReplacement(const MyProfileScreen());
            },
          ),
        );
  }

////////////////////////////////////////////////////////////

  uploadCreditsFlies() async {
    emit(UploadCreditsFilesLoadingState());
    await UploadCreditsFile().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(
                  msg: translateString(
                      "There is an error while uploading files , please try again later",
                      "حدث خطأ ما اثناء تحميل الملفات الرجاء المحاولة في وقت لاحق",
                      ""),
                  state: ToastStates.ERROR);
              emit(UploadCreditsFilesErrorState());
            },
            (r) {
              SelectCreditsItem.filePathApi.clear();
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(UploadCreditsFilesSuccessState());
            },
          ),
        );
  }

  //////////////////////////////////////////////////////
  CreidtsModel? creidtsModel;
  Future getAllCredits() async {
    emit(GetCreidtsLoadingState());
    await GetCreditsAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetCreidtsErrorState());
            },
            (r) {
              creidtsModel = r;
              emit(GetCreidtsSuccessState());
              return creidtsModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////
  deleteLanguage(int languageId) async {
    emit(DeleteLanguageLoadingState());
    await DeleteLanguageAction(languageId).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(DeleteLanguageErrorState());
            },
            (r) {
              print(r!.message!);
              emit(DeleteLanguageSuccessState());
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////
  deleteCredits(int creditId) async {
    emit(DeleteCreditsLoadingState());
    await DeleteCreditsAction(creditId).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(DeleteCreditsErrorState());
            },
            (r) {
              print(r!.message!);
              emit(DeleteCreditsSuccessState());
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////
  deleteSpecialicity(int specialicityId) async {
    emit(DeleteSpecialicityLoadingState());
    await DeleteSpecialicityAction(specialicityId).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(DeleteSpecialicityErrorState());
            },
            (r) {
              print(r!.message!);
              emit(DeleteSpecialicitySuccessState());
            },
          ),
        );
  }
}
