
import 'package:cryp_rage/screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CryptoFiatToggle extends HookConsumerWidget {
  const CryptoFiatToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double imageDiameter = 35;
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  homeFragmentVn.value = 0;
                },
                child: ValueListenableBuilder(
                  valueListenable: homeFragmentVn,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: value == 0 ? Colors.transparent : Colors.grey,
                        ),
                        color: value == 0 ? Colors.amber : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "asset/home/fiat.png",
                              width: imageDiameter,
                              height: imageDiameter,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "FIAT",
                              style: TextStyle(
                                color: value == 0 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  homeFragmentVn.value = 1;
                },
                child: ValueListenableBuilder(
                  valueListenable: homeFragmentVn,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: value == 1 ? Colors.transparent : Colors.grey,
                        ),
                        color: value == 1 ? Colors.amber : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "asset/home/btc.png",
                              width: imageDiameter,
                              height: imageDiameter,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "CRYPTO",
                              style: TextStyle(
                                color: value == 1 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
