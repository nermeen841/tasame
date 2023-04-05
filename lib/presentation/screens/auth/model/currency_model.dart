class CurrencyModel {
  int? id;
  String? name;
  String? code;
  String? symbol;
  String? exchangeRate;

  CurrencyModel(
      {this.id, this.name, this.code, this.symbol, this.exchangeRate});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    exchangeRate = json['exchange_rate'];
  }
}
