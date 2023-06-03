import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/pages/login.dart';

const _firstColor = Color(0xffe84a5f);
const _secondColor = Color(0xff252525);

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _helpText(
                '\t\t\t\tKesan untuk mata kuliah TPM ini sangat seru karena saya sudah pernah mencoba pemrograman menggunakan bahasa pemrograman dart / flutter sebelumnya. Dengan adanya banyak tugas dari makul ini saya jadi merasa tertantang untuk mengerjakan tugas yang ada.'),
            const SizedBox(height: 80),
            _logoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _helpText(String text) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: const TextStyle(
          color: _firstColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: _firstColor,
          backgroundColor: _secondColor,
          shadowColor: Colors.black,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: const Size(90, 40),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(
            color: _firstColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
      ),
    );
  }
}
