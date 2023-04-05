part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class MakeOrderLoadingState extends OrdersState {}

class MakeOrderErrorState extends OrdersState {}

class MakeOrderSuccessState extends OrdersState {}

class GetOrderLoadingState extends OrdersState {}

class GetOrderErrorState extends OrdersState {}

class GetOrderSuccessState extends OrdersState {}

class SendPromoCodeLoadingState extends OrdersState {}

class SendPromoCodeErrorState extends OrdersState {}

class SendPromoCodeSuccessState extends OrdersState {}

class GetUserBookingLoadingState extends OrdersState {}

class GetUserBookingErrorState extends OrdersState {}

class GetUserBookingSuccessState extends OrdersState {}
