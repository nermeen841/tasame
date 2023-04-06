// ignore_for_file: avoid_print, depend_on_referenced_packages, deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/presentation/screens/layout/layuot.dart';
import 'package:zat/presentation/screens/qustionare/action/getquestions.dart';
import 'package:zat/presentation/screens/qustionare/action/make_questionare.dart';
import 'package:zat/presentation/screens/qustionare/action/payment_method.dart';
import 'package:zat/presentation/screens/qustionare/action/quastionare_order.dart';
import 'package:zat/presentation/screens/qustionare/model/orders.dart';
import 'package:zat/presentation/screens/qustionare/model/payment_types.dart';
import 'package:zat/presentation/screens/qustionare/model/quastionare.dart';
import 'package:zat/presentation/screens/qustionare/model/questions.dart';
import 'package:zat/presentation/screens/qustionare/widget/result_screen.dart';
import '../../../../core/router/router.dart';
import '../action/getquastionare.dart';
import '../action/show_result.dart';
import '../model/make_quastionare_ordder.dart';
import '../widget/questionsview.dart';
part 'quastionaire_state.dart';

class QuastionaireCubit extends Cubit<QuastionaireState> {
  QuastionaireCubit() : super(QuastionaireInitial());

  QuastionarModel? quastionarModel;
  Future getQuastionare() async {
    emit(GetQuastionaireLoadingState());
    await GetQuastionareActions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetQuastionaireErrorState());
            },
            (r) {
              quastionarModel = r;
              emit(GetQuastionaireSuccesstate());
              return quastionarModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////
  QuestionsModel? questionsModel;
  getQuestions(quastionareID) async {
    emit(GetQuestionsLoadingState());
    await GetQuestionActions(quastionareID).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetQuestionsErrorState());
            },
            (r) {
              questionsModel = r;
              emit(GetQuestionsSuccesstate());
              MagicRouter.navigateTo(QustionsView(
                quastionareId: quastionareID,
              ));
              return quastionarModel;
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////
  PaymentTypesModel? paymentTypesModel;
  getPaymentTypes() async {
    emit(PaymentTypesLoadingState());
    await PaymentTypesActions().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(PaymentTypesErrorState());
            },
            (r) {
              paymentTypesModel = r;
              emit(PaymentTypesSuccesstate());
              return paymentTypesModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////////////////
  MakeQuastionareOrderModel? makeQuastionareOrderModel;
  postMakeQuestionare({
    required int questionareId,
    required int paymentType,
  }) async {
    emit(MakeQuestionareLoadingState());
    await MakeQuestionareActions(questionareId, paymentType).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(MakeQuestionareErrorState());
            },
            (r) async {
              if (r!.message == "تم  الاشتراك فى هذه الاستبيان من قبل .") {
                showToast(msg: r.message!, state: ToastStates.ERROR);
                emit(MakeQuestionareSuccesstate());
              } else {
                showToast(msg: r.message!, state: ToastStates.SUCCESS);
                makeQuastionareOrderModel = r;
                await launch(r.data!.redirectUrl!);
                getQuestions(questionareId);
                emit(MakeQuestionareSuccesstate());
                // MagicRouter.pop();
                return makeQuastionareOrderModel;
              }
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////
  QuastionareOrdersModel? quastionareOrdersModel;
  getQuastionareOrders() async {
    emit(QuastionareOrdersLoadingState());
    await QuastionareOrdersAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(QuastionareOrdersErrorState());
            },
            (r) {
              quastionareOrdersModel = r;
              emit(QuastionareOrdersSuccesstate());
              return quastionareOrdersModel;
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////////

  getQuastionareResult(int quastionareId, int result) async {
    emit(QuastionareResultLoadingState());
    await ShowResultQuationareAction(quastionareId, result).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(QuastionareResultErrorState());
            },
            (r) async {
              if (r!.message != "questionnaire done later") {
                emit(QuastionareResultSuccesstate());
                MagicRouter.navigateAndPReplacement(
                    ResultScreen(result: result.toString(), url: r.data!.pdf!));
              } else {
                showToast(msg: r.message!, state: ToastStates.ERROR);
                emit(QuastionareResultSuccesstate());
                MagicRouter.navigateAndPopAll(const LayoutScreen(
                  index: 4,
                ));
              }
            },
          ),
        );
  }
}
