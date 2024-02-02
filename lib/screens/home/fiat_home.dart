import 'dart:async';

import 'package:cryp_rage/backend/contoller/getPriceEntryRepo.dart';
import 'package:cryp_rage/backend/futureController/getCurrenciesFutureController.dart';
import 'package:cryp_rage/backend/models/PairPrice.dart';
import 'package:cryp_rage/backend/models/currencies.dart';
import 'package:cryp_rage/util/numberformart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FiatHome extends HookConsumerWidget {
  const FiatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getCurrenciesFutureController).when(data: (data) {
      return Home(currencies: data.object as CurrenciesResponse);
    }, error: (_, trace) {
      return Center(child: Text("Error fetching currencies\n${trace.toString()}"));
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

class Home extends HookConsumerWidget {
  final CurrenciesResponse currencies;

  const Home({Key? key, required this.currencies}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    ValueNotifier<PairPrice> btcPairPriceVn = ValueNotifier(PairPrice(
      data: PairPriceData(),
    ));

    return Material(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: currencies.data.length,
        itemBuilder: (BuildContext context, int index) {
          var data = currencies.data[index];
          return USDPairCard(data: data);
        },
      ),
    );
  }
}

class USDPairCard extends HookConsumerWidget {
  const USDPairCard({super.key, required this.data});

  final CurrencyData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var firstCall = true;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.grey.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${data.id}USD : ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (_, void Function(void Function()) setState) {
                        //Timer.periodic(const Duration(seconds: 7), (timer) {
                        //  //if(!firstCall) setState((){});
                        //});
                        return FutureBuilder(
                          future: getPairPrice(context, ref, data.id),
                          builder: (context, AsyncSnapshot<PairPrice> snapshot) {
                            if(snapshot.hasData){
                              var data = snapshot.data;
                              firstCall = false;
                              return Text(
                                "\$ ${NumberFormat.twoDecimal(data!.data.amount)}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              );
                            }
                            return const Text(
                              "\$ 0.00",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Text(data.name),
            ],
          ),
        ),
      ),
    );
  }

  Future<PairPrice> getPairPrice(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    var response = await ref
        .watch(getPairPriceController)
        .getPairPriceController("$id-USD");
    if (response.status == true) {
      return Future.value(response.object as PairPrice);
    } else {
      return Future.value(PairPrice(data: PairPriceData()));
    }
  }
}
