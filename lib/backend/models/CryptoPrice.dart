class CryptoPrice {
  CryptoPriceData data = CryptoPriceData(rates: {});

  CryptoPrice({required this.data});

  Map<String, dynamic> getMap() {
    return {'data': data};
  }

  CryptoPrice.getData(Map<String, dynamic> map) {
    data = CryptoPriceData.getData(map["data"]);
  }
}

class CryptoPriceData {
  String currency = "";
  Map<String, dynamic> rates = {};

  CryptoPriceData({this.currency = "", required this.rates});

  Map<String, dynamic> getMap() {
    return {'currency': currency, 'rates': rates};
  }

  CryptoPriceData.getData(Map<String, dynamic> map) {
    currency = map["currency"];
    rates = map["rates"];
  }
}
