import 'package:cryp_rage/backend/models/CryptoRate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'bot_landing.dart';

class SortResult extends StatelessWidget {
  const SortResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<String> menuList = ["Sort by highest", "Sort by lowest"];

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Order",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  onPressed: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(width, 0, 0, 0),
                      items: menuList.map((e) {
                        var sortIndex = menuList.indexOf(e);
                        return PopupMenuItem(
                          onTap: () {
                            setState(() {
                              sortData(sort: sortIndex);
                            });
                          },
                          child: Text(e),
                        );
                      }).toList(),
                    );
                  },
                  icon: const Icon(Icons.more_vert_outlined),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: ValueListenableBuilder(
              valueListenable: pricesVn,
              builder: (_, List<CryptoRate> value, __) {
                if (value.isNotEmpty) {
                  return ListView.builder(
                    itemCount: value.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var data = value[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("${data.currency}: ${data.rate}"),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitDualRing(size: 70, color: Colors.amber),
                      SizedBox(height: 64),
                      Text("Loading rates..."),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void sortData({required int sort}) {
    var list = pricesVn.value;
    if(sort == 0){
      list.sort((a, b)=> b.rate.compareTo(a.rate));
      pricesVn.value = [];
    } else if(sort == 1) {
      list.sort((a, b)=> a.rate.compareTo(b.rate));
      pricesVn.value = [];
    }
    pricesVn.value = list;
  }
}
