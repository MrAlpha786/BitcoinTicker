import 'package:bitcoin_ticker_flutter/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: const ColorScheme.dark().copyWith(
            surface: Colors.lightBlue,
            primary: Colors.lightBlue,
          ),
          scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
}
