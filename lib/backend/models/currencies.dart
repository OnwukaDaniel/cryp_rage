class CurrenciesResponse {
  List<CurrencyData> data = [];

  CurrenciesResponse({
    required this.data,
  });

  Map<String, dynamic> getMap() {
    return {
      'data': data,
    };
  }

  CurrenciesResponse.getData(Map<String, dynamic> map) {
    List<CurrencyData> lstData = [];
    for(dynamic d in map["data"] as List<dynamic>){
      lstData.add(CurrencyData.getData(d));
    }
    data = lstData;
  }
}

class CurrencyData {
  String id = "";
  String min_size = "";
  String name = "";

  CurrencyData({
    this.id = "",
    this.min_size = "",
    this.name = "",
  });

  Map<String, dynamic> getMap() {
    return {
      'id': id,
      'min_size': min_size,
      'name': name,
    };
  }

  CurrencyData.getData(Map<String, dynamic> map) {
    id = map["id"];
    min_size = map["min_size"];
    name = map["name"];
  }
}
