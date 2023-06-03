import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/pages/city.dart';
import 'package:weather_api_indonesia/pages/currency.dart';
import 'package:weather_api_indonesia/pages/login.dart';
import 'package:weather_api_indonesia/pages/profile.dart';
import 'package:weather_api_indonesia/pages/time.dart';
import 'package:weather_api_indonesia/pages/userlist.dart';
import 'package:weather_api_indonesia/widget/cards.dart';

const _secondColor = Colors.black;

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(color: _secondColor),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          HomeCard(
            text: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          HomeCard(
            text: 'Weather API',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CityPage(),
                ),
              );
            },
          ),
          HomeCard(
            text: 'Konversi Mata Uang',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CurrencyConversionPage(),
                ),
              );
            },
          ),
          HomeCard(
            text: 'Konversi Waktu',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TimeConversionPage(),
                ),
              );
            },
          ),
          HomeCard(
            text: 'User List',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserListPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
