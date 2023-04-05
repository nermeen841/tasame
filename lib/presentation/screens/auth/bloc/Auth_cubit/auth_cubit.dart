// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/auth/actions/confirm_code.dart';
import 'package:zat/presentation/screens/auth/actions/delete_account.dart';
import 'package:zat/presentation/screens/auth/actions/forget_password.dart';
import 'package:zat/presentation/screens/auth/actions/login.dart';
import 'package:zat/presentation/screens/auth/actions/logout_action.dart';
import 'package:zat/presentation/screens/auth/actions/register.dart';
import 'package:zat/presentation/screens/auth/actions/reset_password.dart';
import 'package:zat/presentation/screens/auth/model/currency_model.dart';
import 'package:zat/presentation/screens/auth/model/user_model.dart';
import 'package:zat/presentation/screens/splash/splash.dart';
import '../../actions/get_country.dart';
import '../../model/country.dart';
import 'package:http/http.dart' as http;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  CountryModel? countryModel;
  Future<CountryModel> getcountry() async {
    emit(GetCountryLoadingState());
    await GetCountryActions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetCountryErrorState());
            },
            (r) {
              countryModel = r;
              emit(GetCountrySuccessState());

              return countryModel!;
            },
          ),
        );
    return countryModel!;
  }

  //////////////////////////////////////////////////////////////////
  UserModel? userModel;
  postRegister({
    required String mobile,
    required String email,
    required String name,
    required String password,
    required int roleId,
    required int gender,
  }) async {
    emit(RegisterLoadingState());
    await RegisterActions(mobile, email, name, password, roleId, gender)
        .run()
        .then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(RegisterErrorState());
            },
            (r) {
              userModel = r;
              prefs.setString("token", r!.accessToken.toString());
              emit(RegisterSuccessState());
            },
          ),
        );
  }
  ////////////////////////////////////////////////////////////////

  postLogin({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoadingState());

    await LoginActions(phone, password).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              prefs.setBool("login", false);
              emit(LoginErrorState());
            },
            (r) {
              userModel = r;
              prefs.setString("token", r!.accessToken.toString());
              prefs.setBool("login", true);
              if (r.data!.roleId == "2") {
                prefs.setString("code", r.data!.passCode.toString());
                prefs.setString("user_type", "user");
              } else {
                prefs.setString("code", r.data!.passCode.toString());
                prefs.setString("user_type", "consultant");
              }
              emit(LoginSuccessState());
            },
          ),
        );
  }
  //////////////////////////////////////////////////

  postForgetPassword({required String phone}) async {
    emit(ForgetPasswordLoadingState());
    await ForgetPasswordActions(phone).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(ForgetPasswordErrorState());
            },
            (r) {
              userModel = r;
              prefs.setString("code", r!.data!.passCode.toString());
              prefs.setString("token", r.accessToken.toString());
              emit(ForgetPasswordSuccessState());
              return userModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////////
  postConfirmCode({required String code}) async {
    emit(ConfirmCodeLoadingState());
    await ConfirmCodeActions(code).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(
                  msg: translateString(
                      "code is invalid", "الكود غير صحيح", "kod geçersiz"),
                  state: ToastStates.ERROR);
              emit(ConfirmCodeErrorState());
            },
            (r) {
              userModel = r;
              emit(ConfirmCodeSuccessState());
              return userModel;
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////
  postResetPassword({required String password}) async {
    emit(ResetPasswordLoadingState());
    await ResetPassowrdActions(password).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(ResetPasswordErrorState());
            },
            (r) {
              userModel = r;
              emit(ResetPasswordSuccessState());
              return userModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////////////
  postDeleteAccount() async {
    emit(DeleteAccountLoadingState());
    await DeleteAccountAction().run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(DeleteAccountErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              prefs.clear();
              emit(DeleteAccountSuccessState());
              MagicRouter.navigateAndPopAll(const SplashScreen());
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////
  postLogOut() async {
    emit(LogoutLoadingState());
    await LogoutAction().run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(LogoutErrorState());
            },
            (r) {
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              prefs.remove("login");
              prefs.remove("token");
              emit(LoginSuccessState());
              MagicRouter.navigateAndPopAll(const SplashScreen());
            },
          ),
        );
  }

///////////////////////////////////////////////////////////
  List<CurrencyModel> currencyModel = [];
  Future<List<CurrencyModel>> getcurrency() async {
    emit(CurrencyLoadingState());
    try {
      var response =
          await http.get(Uri.parse("https://thaatty.com/api/currencies"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data) {
          CurrencyModel model = CurrencyModel.fromJson(item);
          if (prefs.getString("currency") == model.code) {
            prefs.setString("ratio", model.exchangeRate!);
          }
          currencyModel.add(model);
        }
        print(prefs.getString("ratio"));
        emit(CurrencySuccessState());
        return currencyModel;
      }
    } catch (e) {
      print(e.toString());
      emit(CurrencyErrorState());
    }
    return currencyModel;
  }
}
