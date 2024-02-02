class ApiResponse {
  bool status = false;
  Object? object;
  ApiResponse({this.status = false, this.object});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["object"] = object;
    return data;
  }

  ApiResponse.fromJson(Map<String, dynamic> map) {
    status = map["status"];
    object = map["object"];
  }
}