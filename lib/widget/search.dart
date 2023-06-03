import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/model/weather_model.dart';
import 'package:weather_api_indonesia/pages/weather.dart';
import '../model/city_model.dart';

class SearchUser extends SearchDelegate {
  final City city = City();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<City>>(
      future: City.fetchCities(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('An error occurred'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data'),
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final city = snapshot.data![index];
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${city.district}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${city.name}',
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                onTap: () async {
                  await Weather.fetchWeather(snapshot.data?[index].id).then(
                    (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherPage(
                            weatherData: value,
                            cityName: snapshot.data?[index].name,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search'),
    );
  }
}
