import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cryp_rage/backend/constants/APICode.dart';
import 'package:cryp_rage/backend/models/currencies.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final getCurrenciesEntryRepo = Provider((_) => GetCurrenciesEntryRepo());

class GetCurrenciesEntryRepo {
  Future<ApiResponse> getCurrencies() async {
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};

    Response response = await http.get(
      Uri.parse('https://api.coinbase.com/v2/currencies'),
      headers: headers,
    );
    if (response.statusCode == SUCCESS) {
      return ApiResponse(
        status: true,
        object: CurrenciesResponse.getData(jsonDecode(response.body)),
      );
    } else {
      return ApiResponse(
        status: false,
        object: response.body,
      );
    }
  }
}
