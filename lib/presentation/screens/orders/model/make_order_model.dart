class MakeOrderModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  MakeOrderModel({this.message, this.data, this.status, this.statusCode});

  MakeOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  String? tranRef;
  String? tranType;
  String? cartId;
  String? cartDescription;
  String? cartCurrency;
  String? cartAmount;
  String? tranCurrency;
  String? tranTotal;
  String? callback;
  String? returnUrl;
  String? redirectUrl;
  int? serviceId;
  int? profileId;
  int? merchantId;
  String? trace;

  Data(
      {this.tranRef,
      this.tranType,
      this.cartId,
      this.cartDescription,
      this.cartCurrency,
      this.cartAmount,
      this.tranCurrency,
      this.tranTotal,
      this.callback,
      this.returnUrl,
      this.redirectUrl,
      this.serviceId,
      this.profileId,
      this.merchantId,
      this.trace});

  Data.fromJson(Map<String, dynamic> json) {
    tranRef = json['tran_ref'];
    tranType = json['tran_type'];
    cartId = json['cart_id'];
    cartDescription = json['cart_description'];
    cartCurrency = json['cart_currency'];
    cartAmount = json['cart_amount'];
    tranCurrency = json['tran_currency'];
    tranTotal = json['tran_total'];
    callback = json['callback'];
    returnUrl = json['return'];
    redirectUrl = json['redirect_url'];
    serviceId = json['serviceId'];
    profileId = json['profileId'];
    merchantId = json['merchantId'];
    trace = json['trace'];
  }
}
