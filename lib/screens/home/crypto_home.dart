import 'package:cryp_rage/backend/contoller/getCryptoPriceEntryRepo.dart';
import 'package:cryp_rage/backend/contoller/getPriceEntryRepo.dart';
import 'package:cryp_rage/backend/futureController/getCryptoCurrenciesFutureController.dart';
import 'package:cryp_rage/backend/models/CryptoCurrenciesResponse.dart';
import 'package:cryp_rage/backend/models/CryptoPrice.dart';
import 'package:cryp_rage/backend/models/PairPrice.dart';
import 'package:cryp_rage/util/numberformart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CryptoHome extends HookConsumerWidget {
  const CryptoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getCryptoCurrenciesFutureController).when(data: (data) {
      return Crypto(currencies: data.object as CryptoCurrenciesResponse);
    }, error: (_, trace) {
      return const Center(child: Text("Error fetching currencies\nReload"));
    }, loading: () {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: kToolbarHeight),
            SpinKitDualRing(size: 120, color: Colors.amber),
          ],
        ),
      );
    });
  }
}

class Crypto extends HookConsumerWidget {
  final CryptoCurrenciesResponse currencies;

  const Crypto({Key? key, required this.currencies}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: currencies.data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var data = currencies.data[index];
          return USDPairCard(data: data);
        },
      ),
    );
  }

  getPairPrice(
    BuildContext context,
    WidgetRef ref,
    String id,
    ValueNotifier<PairPrice> btcPairPriceVn,
  ) async {
    var response = await ref
        .watch(getPairPriceController)
        .getPairPriceController("$id-USD");
    if (response.status == true) {
      btcPairPriceVn.value = response.object as PairPrice;
    }
  }
}

class USDPairCard extends HookConsumerWidget {
  const USDPairCard({
    super.key,
    required this.data,
  });

  final CryptoCurrencyData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    ValueNotifier<CryptoPrice> cryptoPriceVn = ValueNotifier(
      CryptoPrice(data: CryptoPriceData(rates: {})),
    );
    var isVisible = false;
    getCryptoPrice(context, ref, data.code, cryptoPriceVn);

    return StatefulBuilder(
      builder: (_, void Function(void Function()) setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.circular(12),
            shadowColor: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: cryptoPriceVn,
                builder: (_, CryptoPrice price, Widget? child) {
                  //Naira->USDT -> Other Coins -> (Starting Naira) -> BTC->Naira
                  //Naira->USDT->Other Coins -> Naira
                  //Naira->CYPTO->UsDT -> Naira
                  var usdExchange = price.data.rates["USD"]??"0.00";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isVisible = !isVisible),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width / 2.5,
                              child: Text(
                                "${data.name}USD : ",
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "\$ ${NumberFormat.twoDecimal(usdExchange)}",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(data.name),
                      Visibility(
                        visible: isVisible,
                        child: ValueListenableBuilder(
                          valueListenable: cryptoPriceVn,
                          builder: (_, CryptoPrice price, Widget? child) {
                            var len = price.data.rates.values.length;
                            if (len == 0) {
                              return const SpinKitRotatingCircle(
                                color: Colors.amber,
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: len <= 5 ? len : 5,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var key =
                                        price.data.rates.keys.toList()[index];
                                    var data = price.data.rates[key];
                                    return Row(
                                      children: [
                                        Text("$key : "),
                                        const Spacer(),
                                        Expanded(
                                          child: Text(
                                            "\$ ${NumberFormat.twoDecimal(data)}",
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                len > 5
                                    ? const Text(
                                        "More",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  getCryptoPrice(
    BuildContext context,
    WidgetRef ref,
    String id,
    ValueNotifier<CryptoPrice> cryptoPrice,
  ) async {
    var response =
        await ref.watch(getCryptoPriceController).getCryptoPriceController(id);
    if (response.status == true) {
      cryptoPrice.value = response.object as CryptoPrice;
      SnackBar(content: Text(response.object.toString()));
    }
  }
}
