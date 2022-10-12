import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static Future getExRate(String crypto, String fiat) async {
    double rate = 0.0;
    String baseUrl = 'https://rest.coinapi.io/v1/exchangerate/';

    String? apiKey = dotenv.maybeGet('API_KEY');
    if (apiKey == null) return rate.toStringAsFixed(2);

    Map<String, String> headers = {'X-CoinAPI-Key': apiKey};

    http.Response response =
        await http.get(Uri.parse('$baseUrl$crypto/$fiat'), headers: headers);

    if (response.statusCode == 200) {
      rate = jsonDecode(response.body)['rate'];
    }

    return rate.toStringAsFixed(2);
  }
}
