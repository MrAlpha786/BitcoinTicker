import 'dart:io';

import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  List<Widget> rateCards = [];

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  Widget getExRateCard(String crypto, String rate) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void updateUI() async {
    rateCards.clear();
    for (var crypto in cryptoList) {
      try {
        String rate = await CoinData.getExRate(crypto, selectedCurrency);
        setState(() {
          rateCards.add(getExRateCard(crypto, rate));
        });
      } catch (e) {
        continue;
      }
    }
  }

  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in currenciesList) {
      items.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }

    return DropdownButton(
        value: selectedCurrency,
        items: items,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value as String;
            updateUI();
          });
        });
  }

  CupertinoPicker getIOSPicker() {
    List<Text> items = [];
    for (var item in currenciesList) {
      items.add(Text(item, style: const TextStyle(color: Colors.white)));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            updateUI();
          });
        },
        children: items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Rate Ticker"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rateCards,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getIOSPicker() : getAndroidDropdown(),
          )
        ],
      ),
    );
  }
}
