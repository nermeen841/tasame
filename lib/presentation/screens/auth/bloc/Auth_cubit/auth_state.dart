part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

// get country states
class GetCountryLoadingState extends AuthState {}

class GetCountrySuccessState extends AuthState {}

class GetCountryErrorState extends AuthState {}

// register states
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {}

// login states
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

// forget passowrd states
class ForgetPasswordLoadingState extends AuthState {}

class ForgetPasswordSuccessState extends AuthState {}

class ForgetPasswordErrorState extends AuthState {}

//confirm password code

class ConfirmCodeLoadingState extends AuthState {}

class ConfirmCodeSuccessState extends AuthState {}

class ConfirmCodeErrorState extends AuthState {}

// reset passowrd
class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordErrorState extends AuthState {}

// delete account
class DeleteAccountLoadingState extends AuthState {}

class DeleteAccountSuccessState extends AuthState {}

class DeleteAccountErrorState extends AuthState {}

// log out
class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutErrorState extends AuthState {}

// currency
class CurrencyLoadingState extends AuthState {}

class CurrencySuccessState extends AuthState {}

class CurrencyErrorState extends AuthState {}
