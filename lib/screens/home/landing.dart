import 'dart:async';
import 'dart:developer';

import 'package:cryp_rage/backend/contoller/getPriceEntryRepo.dart';
import 'package:cryp_rage/backend/models/PairPrice.dart';
import 'package:cryp_rage/res/widgets/crypTxt.dart';
import 'package:cryp_rage/screens/Homepage.dart';
import 'package:cryp_rage/screens/bot/bot_landing.dart';
import 'package:cryp_rage/util/numberformart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

ValueNotifier<PairPrice> btcPairPriceVn = ValueNotifier(PairPrice(
  data: PairPriceData(),
));

class Landing extends HookConsumerWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "asset/home/arbitrage.png",
              width: 30,
              height: 30,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(width: 16),
            const Text(
              "Crypo-Trage",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Top 🔥",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              StatefulBuilder(
                  builder: (context, void Function(void Function()) setState) {
                var hasData = false;
                Timer.periodic(Duration(seconds: hasData ? 6 : 3), (timer) {
                  setState(() {});
                });
                return FutureBuilder(
                  future: getPairPrice(context, ref, "BTC"),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    hasData = true;
                    var amount = "";
                    if (snapshot.data == null) {
                      amount = "0.00";
                    } else {
                      amount = (snapshot.data as PairPrice).data.amount;
                    }
                    return buildContainer(amount, "BTC", "btc_logo.png");
                  },
                );
              }),
              const SizedBox(width: 6),
              StatefulBuilder(
                  builder: (context, void Function(void Function()) setState) {
                var hasData = false;
                Timer.periodic(Duration(seconds: hasData ? 6 : 3), (timer) {
                  setState(() {});
                });
                return FutureBuilder(
                  future: getPairPrice(context, ref, "ETH"),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    hasData = true;
                    var amount = "";
                    if (snapshot.data == null) {
                      amount = "0.00";
                    } else {
                      amount = (snapshot.data as PairPrice).data.amount;
                    }
                    return buildContainer(amount, "ETH", "eth_logo.png");
                  },
                );
              }),
            ],
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showDialog(context);
              FirebaseDatabase.instance.ref("READ").get().then((value) {
                final read = value.value as bool;
                if (read) {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Homepage();
                  }));
                } else {
                  Navigator.pop(context);
                }
              });
            },
            child: Material(
              color: const Color(0xb6130f1a),
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Text(
                          "Check",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Crypto Prices",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 1,
                    child: Image.asset(
                      "asset/home/cash.png",
                      width: 120,
                      height: 120,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              _showDialog(context);
              FirebaseDatabase.instance.ref("READ").get().then((value) {
                final read = value.value as bool;
                if (read) {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const BotLanding();
                  }));
                } else {
                  Navigator.pop(context);
                }
              });
            },
            child: Material(
              color: const Color(0xb6130f1a),
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Text(
                          "Arbitrage",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Bot",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 1,
                    child: Image.asset(
                      "asset/home/ai_trade.png",
                      width: 120,
                      height: 120,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(String text, String currency, String icon,
      [bool loading = false]) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          color: const Color(0xb6130f1a),
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("asset/home/$icon",
                          width: 40, height: 40),
                    ),
                    const SizedBox(width: 8),
                    CrypText(
                      text: currency,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CrypText(
                  text: loading ? text : "\$ ${NumberFormat.toCurrency(text)}",
                  style: TextStyle(
                    fontSize: loading ? 15 : 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
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

  void _showDialog(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Material(
          color: Colors.black54,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width / 3,
              vertical: height / 3,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitRotatingCircle(color: Colors.amber, size: 50),
                SizedBox(height: 35),
                Text("Please wait", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }
}
