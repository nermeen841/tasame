part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetAllConsultantLoadingState extends HomeState {}

class GetAllConsultantSuccessState extends HomeState {}

class GetAllConsultantErrorState extends HomeState {}

class MakeRequestLoadingState extends HomeState {}

class MakeRequestSuccessState extends HomeState {}

class MakeRequestErrorState extends HomeState {}

class GetAllRequestLoadingState extends HomeState {}

class GetAllRequestSuccessState extends HomeState {}

class GetAllRequestErrorState extends HomeState {}

class GetLanguageLoadingState extends HomeState {}

class GetLanguageSuccessState extends HomeState {}

class GetLanguageErrorState extends HomeState {}

class GetConsultantDetailLoadingState extends HomeState {}

class GetConsultantDetailSuccessState extends HomeState {}

class GetConsultantDetailErrorState extends HomeState {}

class GetSearchResultLoadingState extends HomeState {}

class GetSearchResultSuccessState extends HomeState {}

class GetSearchResultErrorState extends HomeState {}

class GetFavouriteLoadingState extends HomeState {}

class GetFavouriteSuccessState extends HomeState {}

class GetFavouriteErrorState extends HomeState {}

class AddRemoveFromFavouriteLoadingState extends HomeState {}

class AddRemoveFromFavouriteSuccessState extends HomeState {}

class AddRemoveFromFavouriteErrorState extends HomeState {}

class BookApointmentLoadingState extends HomeState {}

class BookApointmentSuccessState extends HomeState {}

class BookApointmentErrorState extends HomeState {}

class OffersSliderLoadingState extends HomeState {}

class OffersSliderSuccessState extends HomeState {}

class OffersSliderErrorState extends HomeState {}

class OffersTutorsLoadingState extends HomeState {}

class OffersTutorsSuccessState extends HomeState {}

class OffersTutorsErrorState extends HomeState {}

class PartnerLoadingState extends HomeState {}

class PartnerSuccessState extends HomeState {}

class PartnerErrorState extends HomeState {}
