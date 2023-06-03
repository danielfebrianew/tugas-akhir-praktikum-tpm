import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_api_indonesia/utils/currency_key.dart';

Currencies currenciesFromJson(String str) =>
    Currencies.fromJson(json.decode(str));

class Currencies {
  String? disclaimer;
  String? license;
  int? timestamp;
  String? base;
  Map<String, double>? rates;

  Currencies({
    this.disclaimer,
    this.license,
    this.timestamp,
    this.base,
    this.rates,
  });

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  static Future<Currencies> fetchCurrencies() async {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=$currencyAPIKey&base=USD'));
    final results = currenciesFromJson(response.body);

    return results;
  }
}
