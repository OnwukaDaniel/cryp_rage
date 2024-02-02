import 'dart:convert';
import 'dart:developer';

import 'package:cryp_rage/backend/constants/APICode.dart';
import 'package:cryp_rage/backend/models/PairPrice.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final getPairPriceEntryRepo = Provider((_) => GetPairPriceEntryRepo());

class GetPairPriceEntryRepo {
  Future<ApiResponse> getPrice(String pair) async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    Response response = await http.get(
      Uri.parse('https://api.coinbase.com/v2/prices/$pair/spot'),
      headers: headers,
    );
    if (response.statusCode == SUCCESS) {
      return ApiResponse(
        status: true,
        object: PairPrice.getData(jsonDecode(response.body)),
      );
    } else {
      return ApiResponse(
        status: false,
        object: response.body,
      );
    }
  }
}
