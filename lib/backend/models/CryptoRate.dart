class CryptoRate {
  String currency = "";
  double rate = 0.0;

  CryptoRate({this.currency = "", this.rate = 0.0});

  Map<String, dynamic> getMap() => {'currency': currency, 'rate': rate};

  CryptoRate.getData(Map<String, dynamic> map) {
    currency = map["currency"];
    rate = map["rate"];
  }
}
