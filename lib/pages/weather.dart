import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/model/weather_model.dart';

class WeatherPage extends StatelessWidget {
  final List<Weather> weatherData;
  final String? cityName;
  const WeatherPage(
      {Key? key, required this.weatherData, required this.cityName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> weatherCode = {
      '0': "cerah",
      '1': "cerah-berawan",
      '3': "berawan",
      '4': "berawan-tebal",
      '61': "hujan-ringan",
      '63': "hujan-lebat",
      '95': "hujan-petir",
    };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(cityName ?? "No Name")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(),
          children: weatherData.map(
            (weather) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Image(
                    image: AssetImage(
                      'images/${weatherCode[weather.kodeCuaca] ?? 'hujan-ringan'}.png',
                    ),
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text((weather.cuaca ?? "No Name"),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: 330,
                    height: 75,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                        child: Row(
                          children: [
                            customTimeTile('${weather.jamCuaca}'),
                            const VerticalDivider(),
                            customTile('Humidity', '${weather.humidity}%'),
                            const VerticalDivider(),
                            customTile('TempC', '${weather.tempC}\u00B0C'),
                            const VerticalDivider(),
                            customTile('TempF', '${weather.tempF}\u00B0F'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget customTile(String title, String subtitle) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(subtitle, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget customTimeTile(String subtitle) {
    var day = subtitle.substring(0, 10);
    var hour = subtitle.substring(11, 13);
    var minute = subtitle.substring(14, 16);
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          day,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('$hour:$minute WIB', style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
