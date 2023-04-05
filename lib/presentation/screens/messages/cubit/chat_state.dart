part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

// send message
class SendMessageLoadingState extends ChatState {}

class SendMessageErrorState extends ChatState {}

class SendMessageSuccessState extends ChatState {}

// get all chats
class GetAllChatsLoadingState extends ChatState {}

class GetAllChatsErrorState extends ChatState {}

class GetAllChatsSuccessState extends ChatState {}

// get Add ratting
class AddRateLoadingState extends ChatState {}

class AddRateErrorState extends ChatState {}

class AddRateSuccessState extends ChatState {}

class ChangeRateValueState extends ChatState {}

// get communications type
class CommunicationTypesLoadingState extends ChatState {}

class CommunicationTypesErrorState extends ChatState {}

class CommunicationTypesSuccessState extends ChatState {}
