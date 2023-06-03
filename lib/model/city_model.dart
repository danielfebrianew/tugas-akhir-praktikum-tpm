import 'dart:convert';
import 'package:http/http.dart' as http;

class City {
  final String? id;
  final String? province;
  final String? name;
  final String? district;
  final String? latitude;
  final String? longitude;

  City({
    this.id,
    this.province,
    this.name,
    this.district,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      province: json['propinsi'],
      name: json['kota'],
      district: json['kecamatan'],
      latitude: json['lat'],
      longitude: json['lon'],
    );
  }

  static Future<List<City>> fetchCities(String? query) async {
    var data = [];
    List<City> results = [];
    final response = await http.get(
        Uri.parse('https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json'));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      results = data.map((cityJson) => City.fromJson(cityJson)).toList();
      if (query != null) {
        results = results
            .where((element) =>
                element.district!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    } else {
      throw Exception('Failed to load cities');
    }
    return results;
  }
}
