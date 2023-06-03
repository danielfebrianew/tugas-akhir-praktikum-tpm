import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  String? jamCuaca;
  String? kodeCuaca;
  String? cuaca;
  String? humidity;
  String? tempC;
  String? tempF;

  Weather({
    this.jamCuaca,
    this.kodeCuaca,
    this.cuaca,
    this.humidity,
    this.tempC,
    this.tempF,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    jamCuaca = json['jamCuaca'];
    kodeCuaca = json['kodeCuaca'];
    cuaca = json['cuaca'];
    humidity = json['humidity'];
    tempC = json['tempC'];
    tempF = json['tempF'];
  }

  static Future<List<Weather>> fetchWeather(String? id) async {
    var data = [];
    List<Weather> results = [];
    final response = await http
        .get(Uri.parse('https://ibnux.github.io/BMKG-importer/cuaca/$id.json'));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      results = data.map((cityJson) => Weather.fromJson(cityJson)).toList();
    } else {
      throw Exception('Failed to load weather');
    }
    return results;
  }
}
