import 'dart:developer';

class CryptoCurrenciesResponse {
  List<CryptoCurrencyData> data = [];

  CryptoCurrenciesResponse({
    required this.data,
  });

  Map<String, dynamic> getMap() {
    return {
      'data': data,
    };
  }

  CryptoCurrenciesResponse.getData(Map<String, dynamic> map) {
    List<CryptoCurrencyData> lstData = [];
    for(dynamic d in map["data"] as List<dynamic>){
      lstData.add(CryptoCurrencyData.getData(d));
    }
    data = lstData;
  }
}

class CryptoCurrencyData {
  String code = "";
  String name = "";
  String color = "";
  int sort_index = 0;
  int exponent = 0;
  String type = "";
  String address_regex = "";
  String asset_id = "";

  CryptoCurrencyData({
    this.code = "",
    this.name = "",
    this.color = "",
    this.sort_index = 0,
    this.exponent = 0,
    this.type = "",
    this.address_regex = "",
    this.asset_id = "",
  });

  Map<String, dynamic> getMap() {
    return {
      'code': code,
      'name': name,
      'color': color,
      'sort_index': sort_index,
      'exponent': exponent,
      'type': type,
      'address_regex': address_regex,
      'asset_id': asset_id,
    };
  }

  CryptoCurrencyData.getData(Map<String, dynamic> map) {
    code = map["code"];
    name = map["name"];
    color = map["color"];
    sort_index = map["sort_index"];
    exponent = map["exponent"];
    type = map["type"];
    address_regex = map["address_regex"];
    asset_id = map["asset_id"];
  }
}
