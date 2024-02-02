import 'dart:convert';

import 'package:cryp_rage/backend/contoller/getBotCryptoCurrenciesEntryRepo.dart';
import 'package:cryp_rage/backend/contoller/getBotCryptoPriceEntryRepo.dart';
import 'package:cryp_rage/backend/futureController/getBotNGNCryptoCurrenciesFutureController.dart';
import 'package:cryp_rage/backend/models/CryptoCurrenciesResponse.dart';
import 'package:cryp_rage/backend/models/CryptoPrice.dart';
import 'package:cryp_rage/backend/models/CryptoRate.dart';
import 'package:cryp_rage/screens/bot/select_coin.dart';
import 'package:cryp_rage/util/numberformart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'sort_result.dart';

ValueNotifier<CryptoCurrenciesResponse> currenciesVn = ValueNotifier(
  CryptoCurrenciesResponse(data: []),
);

ValueNotifier<List<CryptoRate>> pricesVn = ValueNotifier([]);

class BotLanding extends HookConsumerWidget {
  const BotLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<String> ngnPrice = ValueNotifier("Loading...");
    TextEditingController priceController = TextEditingController();
    var coinOption = "BTC";
    double startingAmount = 1000;

    return StatefulBuilder(
      builder: (context, void Function(void Function()) setState) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          pricesVn.value = [];
        });
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            backgroundColor: Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Bot"),
                ValueListenableBuilder(
                  valueListenable: ngnPrice,
                  builder: (_, String value, Widget? child) {
                    return Text(
                      "NGNUSD: $value",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    );
                  },
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: IconButton(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.refresh),
                ),
              )
            ],
          ),
          body: ref.watch(getBotNGNCryptoCurrenciesFutureController).when(
            data: (data) {
              var ngn =
                  (data.object as CryptoPrice).data.rates["NGN"].toString();
              ngnPrice.value = NumberFormat.twoDecimal(ngn);
              var first = 1 / double.parse(NumberFormat.twoDecimal(ngn));
              var firstUsd = startingAmount * first;

              if (data.status) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text("Enter investment: "),
                              Text(
                                "Optional",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (input) {
                              var input = priceController.text.trim();
                              try {
                                setState(() {
                                  startingAmount = double.parse(
                                    NumberFormat.twoDecimal(input),
                                  );
                                });
                              } catch (e) {}
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              hintText: "Default #1,000",
                              hintStyle: TextStyle(color: Colors.grey),
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Pattern: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("NGN -> USDT-> $coinOption -> NGN"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder(
                      future: getCurrencies(context, ref),
                      builder: (
                        _,
                        AsyncSnapshot<CryptoCurrenciesResponse> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          var dataList = snapshot.data!.data;
                          return ListView.builder(
                            itemCount: dataList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var data = dataList[index];
                              return FutureBuilder(
                                future: getCryptoPrice(context, ref, data.code),
                                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                                  var wait = ConnectionState.waiting;
                                  if (snapshot.connectionState == wait) {
                                    return Text("${data.name}: loading...");
                                  }
                                  if (snapshot.hasData) {
                                    return DataTile(
                                      coinOption: coinOption,
                                      firstUsd: firstUsd,
                                      data: data,
                                      cryptoPrice: snapshot.data as CryptoPrice,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              );
                            },
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: kToolbarHeight),
                                SpinKitDualRing(size: 120, color: Colors.amber),
                              ],
                            ),
                          );
                        } else {
                          return const Text("Error fetching currency\nReload");
                        }
                      },
                    ),
                  ],
                );
              }
              return const Text("Error");
            },
            error: (_, trace) {
              return Center(
                child: Text("Error fetching currencies\n${trace.toString()}"),
              );
            },
            loading: () {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: kToolbarHeight),
                    SpinKitDualRing(size: 120, color: Colors.amber),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return const SelectCoin();
                    }),
                  );
                  var data = result ?? "";
                  if (data.toString().isEmpty) return;
                  var coinSelected = CryptoCurrencyData.getData(
                    jsonDecode(data),
                  );
                  setState(() => coinOption = coinSelected.code);
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 24),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return const SortResult();
                    }),
                  );
                },
                child: pricesVn.value.isNotEmpty
                    ? const Icon(Icons.menu)
                    : const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<CryptoCurrenciesResponse> getCurrencies(
    BuildContext context,
    WidgetRef ref,
  ) async {
    var response = await ref
        .watch(getBotCryptoCurrenciesController)
        .getBotCryptoCurrenciesController();
    if (response.status == true) {
      var currencies = response.object as CryptoCurrenciesResponse;
      currenciesVn.value = currencies;
      return currencies;
    }
    return CryptoCurrenciesResponse(data: []);
  }

  Future<CryptoPrice> getCryptoPrice(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    var response = await ref
        .watch(getBotCryptoPriceController)
        .getBotCryptoPriceController(id);
    if (response.status == true) {
      var data = response.object as CryptoPrice;
      return Future.value(data);
    }
    return Future.value(CryptoPrice(data: CryptoPriceData(rates: {})));
  }
}

class DataTile extends HookConsumerWidget {
  const DataTile({
    super.key,
    required this.coinOption,
    required this.firstUsd,
    required this.data,
    required this.cryptoPrice,
  });

  final String coinOption;
  final double firstUsd;
  final CryptoCurrencyData data;
  final CryptoPrice cryptoPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var map = cryptoPrice.data.rates;
    var price = map[coinOption] ?? "No data";
    var rateSecond = 0.0;
    if (price != "No data") {
      rateSecond = 1 / double.parse(NumberFormat.twoDecimal(price));
    }
    var thirdCur = firstUsd * rateSecond;
    var third = 1 / double.parse(NumberFormat.twoDecimal(map["NGN"]));
    var finalCur = third + thirdCur;
    var removedInf = finalCur == double.infinity? 0.00: finalCur;
    pricesVn.value.add(
      CryptoRate(
        currency: data.name,
        rate: removedInf,
      ),
    );
    return Text(
        "${data.name}: ${NumberFormat.twoDecimal(removedInf.toString())}");
  }
}
