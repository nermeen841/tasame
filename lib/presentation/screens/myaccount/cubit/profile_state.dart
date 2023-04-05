part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

// get profile date for user
class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}

class GetProfileErrorState extends ProfileState {}

// update user profileData
class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileSuccessState extends ProfileState {}

class UpdateProfileErrorState extends ProfileState {}

// update tutor profileData
class UpdateProfileTutorLoadingState extends ProfileState {}

class UpdateProfileTutorSuccessState extends ProfileState {}

class UpdateProfileTutorErrorState extends ProfileState {}

// ADD NEW OFFER
class AddNewOfferLoadingState extends ProfileState {}

class AddNewOfferSuccessState extends ProfileState {}

class AddNewOfferErrorState extends ProfileState {}

// ADD NEW APPOINTMENT
class AddNewAppointmentLoadingState extends ProfileState {}

class AddNewAppointmentSuccessState extends ProfileState {}

class AddNewAppointmentErrorState extends ProfileState {}

// Edit APPOINTMENT
class EditAppointmentLoadingState extends ProfileState {}

class EditAppointmentSuccessState extends ProfileState {}

class EditAppointmentErrorState extends ProfileState {}

// Delete NEW OFFER
class DeleteOfferLoadingState extends ProfileState {}

class DeleteOfferSuccessState extends ProfileState {}

class DeleteOfferErrorState extends ProfileState {}

// Delete appointment
class CancelAppointmentLoadingState extends ProfileState {}

class CancelAppointmentSuccessState extends ProfileState {}

class CancelAppointmentErrorState extends ProfileState {}

// Delete tutor appointment
class DeleteTutorAppointmentLoadingState extends ProfileState {}

class DeleteTutorAppointmentSuccessState extends ProfileState {}

class DeleteTutorAppointmentErrorState extends ProfileState {}

// End room
class EndRoomLoadingState extends ProfileState {}

class EndRoomSuccessState extends ProfileState {}

class EndRoomErrorState extends ProfileState {}

// Get Specialicity
class GetSpecialicityLoadingState extends ProfileState {}

class GetSpecialicitySuccessState extends ProfileState {}

class GetSpecialicityErrorState extends ProfileState {}

// Get credits
class GetCreidtsLoadingState extends ProfileState {}

class GetCreidtsSuccessState extends ProfileState {}

class GetCreidtsErrorState extends ProfileState {}

class UploadCreditsFilesLoadingState extends ProfileState {}

class UploadCreditsFilesSuccessState extends ProfileState {}

class UploadCreditsFilesErrorState extends ProfileState {}

class DeleteLanguageLoadingState extends ProfileState {}

class DeleteLanguageSuccessState extends ProfileState {}

class DeleteLanguageErrorState extends ProfileState {}

class DeleteCreditsLoadingState extends ProfileState {}

class DeleteCreditsSuccessState extends ProfileState {}

class DeleteCreditsErrorState extends ProfileState {}

class DeleteSpecialicityLoadingState extends ProfileState {}

class DeleteSpecialicitySuccessState extends ProfileState {}

class DeleteSpecialicityErrorState extends ProfileState {}
