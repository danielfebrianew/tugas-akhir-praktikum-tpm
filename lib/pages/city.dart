import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/model/city_model.dart';
import 'package:weather_api_indonesia/model/weather_model.dart';
import 'package:weather_api_indonesia/pages/weather.dart';
import 'package:weather_api_indonesia/widget/search.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final city = City();
  final weather = Weather();
  Future<List<City>>? cityResults;
  Future<List<Weather>>? weatherResults;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    cityResults = City.fetchCities(null); // Call the fetchCities() method
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather API'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchPressed,
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: FutureBuilder<List<City>>(
        future: cityResults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              snapshot.data?[index].district ??
                                  "No name available",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          const VerticalDivider(),
                          Text(
                            '${snapshot.data?[index].name}',
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    onTap: () async {
                      await Weather.fetchWeather(snapshot.data?[index].id).then(
                        (value) {
                          Navigator.push(
                            _context,
                            MaterialPageRoute(
                              builder: (context) => WeatherPage(
                                  weatherData: value,
                                  cityName: snapshot.data?[index].district),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _onSearchPressed() {
    showSearch(context: _context, delegate: SearchUser());
  }
}
