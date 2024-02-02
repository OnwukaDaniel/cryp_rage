class PairPrice {
  PairPriceData data = PairPriceData();

  PairPrice({
    required this.data,
  });

  Map<String, dynamic> getMap() {
    return {
      'data': data,
    };
  }

  PairPrice.getData(Map<String, dynamic> map) {
    data = PairPriceData.getData(map["data"]);
  }
}

class PairPriceData {
  String amount = "0.00";
  String currency = "";
  String base = "";

  PairPriceData({
    this.amount = "0.00",
    this.currency = "",
    this.base = "",
  });

  Map<String, dynamic> getMap() {
    return {
      'amount': amount,
      'currency': currency,
      'base': base,
    };
  }

  PairPriceData.getData(Map<String, dynamic> map) {
    amount = map["amount"];
    currency = map["currency"];
    base = map["base"];
  }
}
