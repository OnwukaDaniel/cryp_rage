import 'dart:async';

import 'package:cryp_rage/screens/home/landing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryp-Rage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontFamily: "OpenSans"),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
          return const Landing();
        }), (route) => false);
      }
    });

    return Material(
      color: Colors.amber,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "asset/home/arbitrage.png",
              width: 120,
              height: 120,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
