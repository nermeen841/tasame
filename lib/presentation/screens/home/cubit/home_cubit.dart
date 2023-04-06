// ignore_for_file: avoid_print, depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/presentation/screens/consult_detail/action/book_appointment.dart';
import 'package:zat/presentation/screens/consult_detail/action/consultant_detail.dart';
import 'package:zat/presentation/screens/consult_detail/model/consultantsDetail.dart';
import 'package:zat/presentation/screens/favourite/model/favourite.dart';
import 'package:zat/presentation/screens/home/actions/add_remove_favourite.dart';
import 'package:zat/presentation/screens/home/actions/get_all_consultants.dart';
import 'package:zat/presentation/screens/home/actions/get_all_requests.dart';
import 'package:zat/presentation/screens/home/actions/get_favourite.dart';
import 'package:zat/presentation/screens/home/actions/get_language.dart';
import 'package:zat/presentation/screens/home/actions/get_offers_slider.dart';
import 'package:zat/presentation/screens/home/actions/make_request.dart';
import 'package:zat/presentation/screens/home/actions/partners.dart';
import 'package:zat/presentation/screens/home/actions/search.dart';
import 'package:zat/presentation/screens/home/model/all_consultant.dart';
import 'package:zat/presentation/screens/home/model/language.dart';
import 'package:zat/presentation/screens/home/model/offers.dart';
import 'package:zat/presentation/screens/home/model/partner.dart';
import '../../../../core/router/router.dart';
import '../../consult_detail/consultant_detail.dart';
import '../../tutor_offers/tutor_offers.dart';
import '../actions/tutors_offers.dart';
import '../model/all_consultant_offer.dart';
import '../model/all_request.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  AllConsultantModel? allConsultantModel;
  getAllConsultant() async {
    emit(GetAllConsultantLoadingState());
    await GetAllConsultants().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetAllConsultantErrorState());
            },
            (r) {
              allConsultantModel = r;
              for (var element in r!.data!) {
                isFavourite[element.id!] = element.isFav ?? false;
              }
              emit(GetAllConsultantSuccessState());
              return allConsultantModel;
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////
  LanguageModel? languageModel;
  Future getLanguage() async {
    emit(GetLanguageLoadingState());
    await GetLanguageAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetLanguageErrorState());
            },
            (r) {
              languageModel = r;
              emit(GetLanguageSuccessState());
              return languageModel;
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////
  ConsultantDetailModel? consultantDetailModel;
  Future getConsultantDetail(consultantId, bool fromhome) async {
    emit(GetConsultantDetailLoadingState());
    await GetConsultantDetailAction(consultantId).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetConsultantDetailErrorState());
            },
            (r) {
              consultantDetailModel = r;

              isFavourite[r!.data!.id!] = r.data!.isFav!;

              print(r.message);
              emit(GetConsultantDetailSuccessState());
              if (fromhome) {
                MagicRouter.navigateTo(const ConsultantDetailScreen());
              } else {
                MagicRouter.navigateAndPReplacement(
                    const ConsultantDetailScreen());
              }
              return consultantDetailModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////
  getSearchResult({
    required String keyword,
    required int gender,
    required int rate,
    required int languageID,
    required int specialictyId,
    required String date,
  }) async {
    emit(GetSearchResultLoadingState());
    await SearchActions(keyword, gender, languageID, rate, specialictyId, date)
        .run()
        .then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetSearchResultErrorState());
            },
            (r) {
              allConsultantModel = r;
              allConsultantModel = r;
              for (var element in r!.data!) {
                isFavourite[element.id!] = element.isFav ?? false;
              }
              emit(GetSearchResultSuccessState());
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////////
  Map<int, bool> isFavourite = {};
  postAddRemoveFavourite({
    required int tutorID,
  }) async {
    emit(AddRemoveFromFavouriteLoadingState());
    await AddorRemoveFavouriteActoin(tutorID).run().then(
          (value) => value.fold(
            (l) {
              isFavourite[tutorID] = false;
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(AddRemoveFromFavouriteErrorState());
            },
            (r) {
              if (r!.message! == "تم الحذف بنجاح" ||
                  r.message! == "Deleted successfully" ||
                  r.message! == "Başarıyla silindi") {
                isFavourite[tutorID] = false;
                showToast(
                  msg: r.message!,
                  state: ToastStates.ERROR,
                );
                emit(AddRemoveFromFavouriteSuccessState());
              } else {
                isFavourite[tutorID] = true;
                showToast(msg: r.message!, state: ToastStates.SUCCESS);
                emit(AddRemoveFromFavouriteSuccessState());
              }
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////
  FavouriteModel? favouriteModel;
  getFavouriteData() async {
    emit(GetFavouriteLoadingState());
    await GetFavouriteAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetFavouriteErrorState());
            },
            (r) {
              favouriteModel = r;
              for (var element in r!.data!) {
                isFavourite[element.id!] = true;
              }
              emit(GetFavouriteSuccessState());
              return favouriteModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////////////
  postAppointment({
    required String available_date,
    required String available_hours,
    required int tutor_id,
  }) async {
    emit(BookApointmentLoadingState());
    await BookApointmentAction(available_date, available_hours, tutor_id)
        .run()
        .then(
          (value) => value.fold(
            (l) {
              if (l.message ==
                  "Attempt to read property \"offer_id\" on null") {
                showToast(
                    msg: translateString(
                        "No packages have been subscribed to with this consultant",
                        "لم يتم الاشتراك في اي باقات مع هذا المستشار",
                        ""),
                    state: ToastStates.ERROR);
                print(l.message);
                emit(BookApointmentErrorState());
              } else {
                showToast(msg: l.message, state: ToastStates.ERROR);
                print(l.message);
                emit(BookApointmentErrorState());
              }
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(BookApointmentSuccessState());
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////
  postMakeRequest({required int tutorId, required String message}) async {
    emit(MakeRequestLoadingState());
    await MakeRequestAction(tutorId, message).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(MakeRequestErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(MakeRequestSuccessState());
              MagicRouter.pop();
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////////
  AllRequestModel? allRequestModel;
  getAllRequest() async {
    emit(GetAllRequestLoadingState());
    await AllRequestAction().run().then(
          (value) => value.fold((l) {
            showToast(msg: l.message, state: ToastStates.ERROR);
            emit(GetAllRequestErrorState());
          }, (r) {
            allRequestModel = r;
            emit(GetAllRequestSuccessState());
            return allRequestModel;
          }),
        );
  }

  ///////////////////////////////////////////////////////////////////
  OffersSliderModel? offersSliderModel;
  getofferSlider() async {
    emit(OffersSliderLoadingState());
    await AllOffersSliderAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(OffersSliderErrorState());
            },
            (r) {
              offersSliderModel = r;
              emit(OffersSliderSuccessState());
              return offersSliderModel;
            },
          ),
        );
  }

  ///////////////////////////////////////////////////////////////////
  AllConsultantOffersModel? allConsultantOffersModel;
  Future getofferTutors(int offerId) async {
    emit(OffersTutorsLoadingState());
    await GetTutorOffersAction(offerId).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              // showToast(msg: l.message, state: ToastStates.ERROR);
              emit(OffersTutorsErrorState());
            },
            (r) {
              allConsultantOffersModel = r;
              emit(OffersTutorsSuccessState());
              MagicRouter.navigateTo(const TutorRelatedOffersScreen());
              return allConsultantOffersModel;
            },
          ),
        );
  }

  ///////////////////////////////////////////////////
  PartnerModel? partnerModel;
  Future getPartner() async {
    emit(PartnerLoadingState());
    await PartnerActions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(PartnerErrorState());
            },
            (r) {
              partnerModel = r;
              emit(PartnerSuccessState());
              return partnerModel;
            },
          ),
        );
  }
}
