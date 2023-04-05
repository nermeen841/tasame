// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/network/baseModel.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/contactus/actions/contact_us.dart';
import 'package:zat/presentation/screens/contactus/actions/setting.dart';
import 'package:zat/presentation/screens/contactus/model/setting.dart';
import 'package:zat/presentation/screens/info/action/custom_page.dart';
import 'package:zat/presentation/screens/info/model/custom_page.dart';
import 'package:zat/presentation/screens/intro/action/intro_action.dart';
import 'package:zat/presentation/screens/intro/model/intro_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  BaseModel? baseModel;
  postContactUs({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    emit(ContactUsLoadingState());
    await ContactusActions(name, email, phone, message).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(ContactUsErrorState());
            },
            (r) {
              baseModel = r;
              showToast(msg: r!.message!, state: ToastStates.SUCCESS);
              emit(ContactUsSuccessState());
              MagicRouter.pop();
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////
  SettingModel? settingModel;
  getSettingData() async {
    emit(SettingLoadingState());
    await SettingAcyions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(SettingErrorState());
            },
            (r) {
              settingModel = r;
              emit(SettingSuccessState());
              return settingModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////////
  CustomPagesModel? customPagesModel;
  getCustomPage() async {
    emit(CustomPageLoadingState());
    await CustomPageActions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(CustomPageErrorState());
            },
            (r) {
              customPagesModel = r;
              emit(CustomPageSuccessState());
              return customPagesModel;
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////////
  AppIntroModel? appIntroModel;
  getAppIntro() async {
    emit(GetAppIntroLoadingState());
    await GetAppIntroAction().run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(GetAppIntroErrorState());
            },
            (r) {
              appIntroModel = r;
              emit(GetAppIntroSuccessState());
              return appIntroModel;
            },
          ),
        );
  }
}
