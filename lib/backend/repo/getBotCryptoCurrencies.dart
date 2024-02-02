import 'dart:convert';
import 'dart:developer';

import 'package:cryp_rage/backend/constants/APICode.dart';
import 'package:cryp_rage/backend/models/CryptoCurrenciesResponse.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final getBotCryptoCurrenciesEntryRepo =
    Provider((_) => GetBotCryptoCurrenciesEntryRepo());

class GetBotCryptoCurrenciesEntryRepo {
  Future<ApiResponse> getBotCryptoCurrencies() async {
    final headers = {};

    Response response = await http.get('Content-Type': 'application/json; charset=UTF-8'
      Uri.parse('https://api.coinbase.com/v2/currencies/crypto'),
      headers: headers,
    );
    if (response.statusCode == SUCCESS) {
      return ApiResponse(
        status: true,
        object: CryptoCurrenciesResponse.getData(jsonDecode(response.body)),
      );
    } else {
      return ApiResponse(
        status: false,
        object: response.body,
      );
    }
  }
}
