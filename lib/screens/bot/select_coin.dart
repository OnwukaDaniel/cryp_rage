import 'dart:convert';

import 'package:cryp_rage/backend/models/CryptoCurrenciesResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'bot_landing.dart';

class SelectCoin extends StatelessWidget {
  const SelectCoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Pair to match",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: currenciesVn,
          builder: (_, CryptoCurrenciesResponse value, __) {
            if (value.data.isNotEmpty) {
              return ListView.builder(
                itemCount: value.data.length,
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var data = value.data[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(
                            context,
                            jsonEncode(data.getMap()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            children: [
                              Text(data.name),
                              const SizedBox(width: 4),
                              Text(data.code),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 0.5,
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: kToolbarHeight),
                  Text("Loading currencies..."),
                  SizedBox(width: 16),
                  SpinKitDualRing(size: 70, color: Colors.amber),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
