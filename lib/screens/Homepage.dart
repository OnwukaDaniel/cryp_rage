import 'dart:async';

import 'package:cryp_rage/backend/contoller/getPriceEntryRepo.dart';
import 'package:cryp_rage/backend/models/PairPrice.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home/crypto_fiat_toggle.dart';
import 'home/crypto_home.dart';
import 'home/fiat_home.dart';

ValueNotifier<int> homeFragmentVn = ValueNotifier(0);
ValueNotifier<bool> loadingDataVn = ValueNotifier(false);

class Homepage extends HookConsumerWidget {
  const Homepage({Key? key}) : super(key: key);
  final Widget fiatHome = const FiatHome();
  final Widget cryptoHome = const CryptoHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> fragment = [fiatHome, cryptoHome];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Price",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          const CryptoFiatToggle(),
          ValueListenableBuilder(
            valueListenable: homeFragmentVn,
            builder: (BuildContext context, int value, Widget? child) {
              return fragment[value];
            },
          ),
        ],
      ),
    );
  }

  Future<PairPrice> getPairPrice(
    BuildContext context,
    WidgetRef ref,
    String id,
    ValueNotifier<PairPrice> btcPairPriceVn,
  ) async {
    var response = await ref
        .watch(getPairPriceController)
        .getPairPriceController("$id-USD");
    if (response.status == true) {
      return Future.value(response.object as PairPrice);
    }
    return Future.value(PairPrice(data: PairPriceData()));
  }
}
