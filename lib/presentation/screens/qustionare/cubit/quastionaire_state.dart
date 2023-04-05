part of 'quastionaire_cubit.dart';

@immutable
abstract class QuastionaireState {}

class QuastionaireInitial extends QuastionaireState {}

class GetQuastionaireLoadingState extends QuastionaireState {}

class GetQuastionaireErrorState extends QuastionaireState {}

class GetQuastionaireSuccesstate extends QuastionaireState {}

class GetQuestionsLoadingState extends QuastionaireState {}

class GetQuestionsErrorState extends QuastionaireState {}

class GetQuestionsSuccesstate extends QuastionaireState {}

class PaymentTypesLoadingState extends QuastionaireState {}

class PaymentTypesErrorState extends QuastionaireState {}

class PaymentTypesSuccesstate extends QuastionaireState {}

class MakeQuestionareLoadingState extends QuastionaireState {}

class MakeQuestionareErrorState extends QuastionaireState {}

class MakeQuestionareSuccesstate extends QuastionaireState {}

class QuastionareOrdersLoadingState extends QuastionaireState {}

class QuastionareOrdersErrorState extends QuastionaireState {}

class QuastionareOrdersSuccesstate extends QuastionaireState {}

class QuastionareResultLoadingState extends QuastionaireState {}

class QuastionareResultErrorState extends QuastionaireState {}

class QuastionareResultSuccesstate extends QuastionaireState {}
