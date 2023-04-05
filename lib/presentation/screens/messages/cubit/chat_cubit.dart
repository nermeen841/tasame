// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/presentation/screens/messages/actions/communication_action.dart';
import 'package:zat/presentation/screens/messages/actions/get_all_chats.dart';
import 'package:zat/presentation/screens/messages/actions/send_message.dart';
import 'package:zat/presentation/screens/messages/actions/tutor_rating.dart';
import 'package:zat/presentation/screens/messages/model/all_chat_model.dart';
import 'package:zat/presentation/screens/messages/model/communications.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  sendMessage({
    required int recieverId,
    required String message,
  }) async {
    emit(SendMessageLoadingState());
    await SendMessageAction(recieverId, message).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(SendMessageErrorState());
            },
            (r) {
              emit(SendMessageSuccessState());
            },
          ),
        );
  }

  ////////////////////////////////////////////////////////////////////////////
  AllChatsModel? allChatsModel;
  getAllChats() async {
    emit(GetAllChatsLoadingState());
    await GetAllChatsAction().run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(GetAllChatsErrorState());
            },
            (r) {
              allChatsModel = r;
              emit(GetAllChatsSuccessState());
              return allChatsModel;
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////////
  postAddRate({
    required int tutorId,
    required double rate,
    required String comment,
  }) async {
    emit(AddRateLoadingState());
    await TutorRattingAction(tutorId, rate, comment).run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(AddRateErrorState());
              MagicRouter.pop();
            },
            (r) {
              if (r!.message == "تم تقييم هذا المنتج من قبل") {
                showToast(msg: r.message!, state: ToastStates.ERROR);
                emit(AddRateSuccessState());

                MagicRouter.pop();
              } else {
                showToast(
                    msg: translateString("Rate added successfully",
                        "تم اضافة التقييم بنجاح", "Oran başarıyla eklendi"),
                    state: ToastStates.SUCCESS);
                emit(AddRateSuccessState());

                MagicRouter.pop();
              }
            },
          ),
        );
  }

  /////////////////////////////////////////////////////////////////////
  double ratting = 0;
  changeRateValue(rateValue) {
    ratting = rateValue;
    emit(ChangeRateValueState());
  }

  ////////////////////////////////////////////
  CommunicationsModel? communicationsModel;
  getCommunicationsMethode() async {
    emit(CommunicationTypesLoadingState());
    await CommunicationActions().run().then(
          (value) => value.fold(
            (l) {
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(CommunicationTypesErrorState());
            },
            (r) {
              communicationsModel = r;
              emit(CommunicationTypesSuccessState());
              return communicationsModel;
            },
          ),
        );
  }
}
