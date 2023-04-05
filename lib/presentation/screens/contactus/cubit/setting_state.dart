part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class ContactUsLoadingState extends SettingState {}

class ContactUsSuccessState extends SettingState {}

class ContactUsErrorState extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingSuccessState extends SettingState {}

class SettingErrorState extends SettingState {}

class CustomPageLoadingState extends SettingState {}

class CustomPageSuccessState extends SettingState {}

class CustomPageErrorState extends SettingState {}

class GetAppIntroLoadingState extends SettingState {}

class GetAppIntroSuccessState extends SettingState {}

class GetAppIntroErrorState extends SettingState {}
